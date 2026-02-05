Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33AB36403D;
	Thu,  5 Feb 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307642; cv=none; b=Pn0rs/XarLyRZFcvQEY0Up9q2E9YJ+cTDVwQvaHio58hRSRKyoX1igYdoDlIW4G6fNA1HEeB8C7p1mkrZdBaZZElZHN9CPCJy3fb/L6fM3y9J7NgI0b8xB06QKMyDRriP4OlirVbfD4rNRoUu4PqfoQhNOYJwjoS3S7FgRGqnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307642; c=relaxed/simple;
	bh=GXk+GzpG5GSnwfsf0UKSPYlVGU+6DX3r9ClEXhUTjts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XI72R3hk71eseV+XEZ+y51GBYYXe4rVyT22Zrij+WIvmzgG/TRiizH/yLouH6xh0RYvJ67IYAVdKWX9CYgoz9gSMpy2BGQXiKfSC42zyHokD3tOgshJbwA80N5FRVfAgq4bIhlhQnJuTpFAQZQBlqHc0G0/+O/ILr1Hoq1K7UNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMYr34hu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMYr34hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF1CC4CEF7;
	Thu,  5 Feb 2026 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770307642;
	bh=GXk+GzpG5GSnwfsf0UKSPYlVGU+6DX3r9ClEXhUTjts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HMYr34huf+UgYUqaxT6/MP74d67CCdlMMq+SY47udR3Zqi5TZuAgUmsfd1SNSMdXz
	 eizscw0BCSIlkrzGiTYFU3ZGDSiqMmcY2dxFpJKjBcqnF21XPTZ80K4ZyaFD4+jPWD
	 qzO5S1ZzhmACywclQJdSHzG9ic98x1nwrKgDF452i+bQ5xO6yhpfbBDLskk3Kl+y6R
	 IKRs1nSS6unzFt5O8RUUcjfnYuBofpXrPfrrk5hD+LsupG7jOdxyVRyB+Nq6e+kjEU
	 s5D5X5QDF05QC9H+yZf/f5wS8hFQnWB5HmmwYJpRVEb9yU6hoRPgIO7KWBM8clca8k
	 6Vw+YdgewvGsw==
Date: Thu, 5 Feb 2026 08:07:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Dege <michael.dege@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikita
 Yushchenko <nikita.yoush@cogentembedded.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: renesas: rswitch: fix forwarding offload
 statemachine
Message-ID: <20260205080720.7d59ef82@kernel.org>
In-Reply-To: <20260205-fix-offloading-statemachine-v2-1-fafcf0c6eb1d@renesas.com>
References: <20260205-fix-offloading-statemachine-v2-1-fafcf0c6eb1d@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Feb 2026 14:35:21 +0100 Michael Dege wrote:
> A change of the port state of one port, caused the state of another
> port to change. This behvior was unintended.
> 
> Signed-off-by: Michael Dege <michael.dege@renesas.com>
> ---
> A change of the port state of one port, caused the state of another
> port to change. This behvior was unintended.
> 
> Fixes: b7502b1043de86967ff341819d05e09a8dbe8b2b ("net: renesas: rswitch: add offloading for L2 switching")

Please wait 24h before posting a next version of a patch per:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

The Fixes tag is not in the right place here, it should be above your
SoB and the hash is too long (consult the Documentation/ for exact
format)
-- 
pw-bot: cr
