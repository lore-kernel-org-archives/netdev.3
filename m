Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D74377ECA;
	Thu,  7 May 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163894; cv=none; b=uxMiD1LNJ66kVKRld30OXeZqHb94DaVGpgumD5V8ll26nvFg+9c+JQLkJlKj4tjrdmqVA/aLcUkmKlkJAyWY9pBuL8uPEMNsfrOqFGe3M7TrTyVv0rNNAB29MhrmNwQAOj6ACApG0SQwnLNGoDijipkOp4xdzlq4SGonVjXqicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163894; c=relaxed/simple;
	bh=4lilMs948IYlQl6ri0OAC72uCbA9hsTvsd8egJfCE3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaGQ7Jd5K9+LOGNu39U5w3Pmo0wnkxdykVAct3p80ovhKH3OToO/JcIOeKnOEHkB1eBaaBtGZ7HGDqzokOW5KFkHGipa5d1ksSSTWMvDGwoD2T5AN5P1GqtcD0feLbHvE7/JRitlUCT5fx1tUKt/QkEpUc/OrUIr22cRkq3jag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2os0FMW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2os0FMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FC3C2BCB2;
	Thu,  7 May 2026 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778163894;
	bh=4lilMs948IYlQl6ri0OAC72uCbA9hsTvsd8egJfCE3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2os0FMWP+JnSdIg23ZhaO/0eofNT5+4aiHRg/kRB/zy2Fv6huRDKDSjmFyXimFxM
	 f6NJLuNq+vpVwLrJ1nBOL6WX8TtY4XojsIq+a2sFKKd5XN73QSIlLR+nPi0Vy45Wwh
	 CriBhchQImNsxECTVURa7XgZYER5Hpfs1DsnGCYkb6giRfwf28NyT+CC+yh+rDZqgz
	 8uLanBDQp+8wz++FWEy29P3dIy0fqwZn8JNL221u8QAdeh2oAFeNWYvg9DLEYzofLj
	 UzHEmR7xzkSk8zdFXEV/IRCvnpAiCa7NkYXEhK4LzA5yr6/14sxtQP+1nJG6EmxJAH
	 8B3/HYJWz0+gA==
Date: Thu, 7 May 2026 07:24:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Alexander Duyck
 <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net v2] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <20260507072453.5eec7051@kernel.org>
In-Reply-To: <6cec0c03-5bdc-4131-9899-bc5c77fba198@redhat.com>
References: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
	<6cec0c03-5bdc-4131-9899-bc5c77fba198@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 12:34:24 +0200 Paolo Abeni wrote:
> > Clearing fbd->netdev to NULL avoids UAF in init_failure_mode where
> > callers guard by checking !fbd->netdev, such as fbnic_mdio_read_pmd().
> > These callers remain active even after a failed probe, so fdb->netdev
> > still needs to be cleared.
> > 
> > Fixes: d0fe7104c795 ("fbnic: Replace use of internal PCS w/ Designware XPCS")
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>  
> 
> Note that sashiko-gemini spotted a pre-existing issue:
> 
> https://sashiko.dev/#/patchset/20260504-fbnic-pcs-fix-v2-1-de45192821d9%40meta.com
> 
> does not block this patch but could deserve a follow-up.

fbd is a devlink priv, not netdev priv, touching it after free_netdev()
is perfectly fine. I wish Gemini tried a *little* harder instead of
guessing :| Sorry for not commenting earlier.
