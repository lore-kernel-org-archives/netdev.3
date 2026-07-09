Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF439A075;
	Thu,  9 Jul 2026 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616946; cv=none; b=q2prLptFaYSmK31VrX0S/xTJdgUMlIsVD6FBvwYI28cFQ7M/HvQswF9erLiJTIuYldc3w+ddYer7t0oov1m0sn5C787HMWW37mqQcgR+0ZXjAiIw5/AeitxxuzkRSk/m8tIIo/wJzRlHh6TOqGiRkPW1fYyc9DsMuxYxvEnq874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616946; c=relaxed/simple;
	bh=vLq+ZBL/xF6wImPiWQK2R72svyXbMMrcMeb4rJdTl74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs/o4BWxixzdcAzA96MaCRrY9mQttyDg+v5OZj1GLxURDqJxvpHgbX6MMmxiDEkk0GadWSnx55UTHeDE9aJYhrGeM4nSel/5xh+DAqvgNFWAn+sMrUZ/KekwkC4aJ+a9mBIxrc95Wxzsx02Szsf+O4j36xCmfoaSyT3URx9wzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3pyjyHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3pyjyHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59DD1F00A3A;
	Thu,  9 Jul 2026 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783616945;
	bh=gNlPURQ5ZFyY+wK1czb08/00XgUWU0beect7DrqaBbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F3pyjyHONMi+TBCVJnCtht8Ee3xC16h9y8nu+pBAW/n80Bb2IV2zDxI4sGZfREgax
	 t8WQFg5IEiOyhEQrUYXdxMcLdgg0NtFzMp3A1uYVOpwMoSwL5ob8VJ4+zI+ra919cu
	 7zzYhW+qRatVRlAXgYlZsUHYms/JEFhNveeumwYX/MnpgJLSBSPDVkOrSe8UuCnB9E
	 z+e6wDdHPz7ufSfyc3jzXgEslM5T0SB0MW80RVWgY1oQQ2eF42kFdMpEt7X1CMSQSk
	 OuinTl1e2+NZ3cbY5Bp9yaeqTFvu4Gnt6wFSqx2aj9xwNyjV71g0pv16eyw8EaMSif
	 Wl+KbT+41XEhg==
Date: Thu, 9 Jul 2026 18:09:01 +0100
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: xscale: add missing MODULE_DEVICE_TABLE()
Message-ID: <20260709170901.GU1364329@horms.kernel.org>
References: <20260704122722.5715-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704122722.5715-1-pengpeng@iscas.ac.cn>

On Sat, Jul 04, 2026 at 08:27:22PM +0800, Pengpeng Hou wrote:
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

