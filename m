Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1CB481FA8;
	Wed, 22 Jul 2026 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710291; cv=none; b=CVrKHws8ZfEbeeJfabkbtWG4EThsaTefMe+CbxfSsj3bbi9lZUchVy1/6SHmGu+wmme1P51P/7qmp0aKtOFREuUhftu39twZNxQr5uuAvKq1N3RL5cGafO0xVPXP3/KyG4ILt6EiiPjDJI2BO5C+U6lG4EYV0FZhlZZfeftVaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710291; c=relaxed/simple;
	bh=28PFpPOTzf9qc/OpgfgsL0lECvhOWdd/z64uUN0+yVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpzTe3p8u3uuPxJa0eb1Q2e5WgUaUjxJzi5j8xrJlHAnkr1NbFI+r50YrIMycznDn17b7FGYZ2VRG4IJkVNvVbw13o41Fqxc8A2OJ9nbLRznUcqv9ofxcMZEhlz10KK5q9mGmHjYpOgwPfFlyefbzegbwV3bGxC91PHyy8R0bPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQcBYehL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQcBYehL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2C81F000E9;
	Wed, 22 Jul 2026 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710290;
	bh=ePIUkcRzigEJy5avPXcawCkba0AVvm0YkIoheOyYOg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQcBYehLOSCYtBJTjKrAVPE2ITPft3gBUmeAyFiUmP2QJlVO8kKFc1dL/62meKC9Z
	 WnR+AOGl3j9sEeJ+lkv4vzcl9kJ+YGs8GsyfeY/xqOS2l64KjN5a96esZF4+hMfyVY
	 laKNm2K5FN+ppBB39pxeGTausX2nnZfZ4RkpCue2AgGhG+V0ctg1LIjz95tYOwvW+x
	 hjy0iCcejlP5Hz01nYW0K8mEKsOyFAAKtr2a+cugD5SrFK+yswO/YpeTaOYYdeaO2E
	 pymT5nlPIvmcKuEen5XtJC/4K/IT+ahntXuQy3D9Wyd1S7ivrhKzpQYYZv5zbAlRRe
	 8pLF3p7XHvICA==
Date: Wed, 22 Jul 2026 11:51:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandre Cassen <acassen@corp.free.fr>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xfrm: Fix skb double-free in xfrm_dev_direct_output()
Message-ID: <20260722085125.GV110966@unreal>
References: <20260722072837.2011916-2-sanghyun.park.cnu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722072837.2011916-2-sanghyun.park.cnu@gmail.com>

On Wed, Jul 22, 2026 at 04:28:38PM +0900, Sanghyun Park wrote:
> A return value other than 1 from local_out() means that the skb has been
> consumed or its ownership was transferred. xfrm_dev_direct_output()
> nevertheless frees the skb on this path, causing a double-free when
> netfilter drops the packet and invalidating any other owner.
> 
> Return the local_out() result directly, matching the ownership handling
> in xfrm_output_resume().
> 
> Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
>  net/xfrm/xfrm_output.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
