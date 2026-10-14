Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAAD568521;
	Wed, 14 Oct 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999366; cv=none; b=ZmFfARmE4l5j0UNDwtw6C+YabxNOZUiyH9x2ayQOVv3lqRbdWTqjjYE8NmMe40AYnYjpmBgkbC6JNbhx1Bb6ghZdPH38zO29KZbh4VVYQl8VK8qirW7xtpjstZCucUBFw+Jg/cj5XNWseNqt9N8TagwJUBXJ6K5KUX26ssItRRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999366; c=relaxed/simple;
	bh=rLQxIJWAv/seD+ddr6G6FD7bgK+FzkSzVXmYXiw6wog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7FCvIGxKSUgVJ46K62j9fKb7fbzSjjoiJgc5liB8gfuZsDWL++FnSnl01+D0ej787O4rePcKkroIT1cJywEcXnQVpXGy1h6JnzDfNg+1EOib4waP1XLksmtVs3RWN6UUOyLiDYn0OeY4K1CU7bVd86hYn5ilzuiEYIhTHJ3JOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Dc+WSIlM; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Dc+WSIlM"
Received: from x1 (M106072126074.v4.enabler.ne.jp [106.72.126.74])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69EGaZFg095707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 15 Oct 2026 01:36:36 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=WBMVjY8YeonBZOvSdmUkR4YHsUWbR6DizhvuUowYl5c=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1791995796; v=1;
        b=Dc+WSIlMSIFT5Of2aJUnUTIQPWZvu077QPVp2qtM2QIP66sBWEcLvv0eorAaYxqe
         Ft5RV7g44YCJ2K/uPUBfUGB/1Xnqvqy705hyYe5T8gs5Ji2awUb28IDtblvwvIwy
         XDhmH9iyHwdWUQM9MsPDGh7WJv3uiY7/0grkfYUV+FvOk1xCCUZSexqdaKxwwKdp
         iFHRGgeFVKQCMOuJ3Ilgje5sa2Q9hbPS093JGLa7zsD7v0nFbscvHeJIhavbVt7L
         1dohrheiB2vkcZVAfv/vLDCXnkxLxBrLtmPvZeQzzjikGQj80v+1TO8m+fwDDUkX
         s4tmMy+NJoVQcqJmP8DdJg==
Date: Thu, 15 Oct 2026 01:36:35 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: intel: ice: Modernize ice_vsi_free() with
 scope-based guard(mutex)
Message-ID: <as-tT0nDrchWa96T@x1>
References: <20261014110552.56976-1-ayush37735@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014110552.56976-1-ayush37735@gmail.com>

On 10/14 16:35, Ayush Yaduvanshi wrote:
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>

The commit message is missing, and this patch seems to be a clean-up
patch, which is discouraged in
Documentation/process/maintainer-netdev.rst. Also, this document says:
    Use of ``guard()`` is discouraged within any function longer than 20 lines

> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d..c695df442822 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -457,7 +457,7 @@ void ice_vsi_free(struct ice_vsi *vsi)
>  		return;
>  	}
>  
> -	mutex_lock(&pf->sw_mutex);
> +	guard(mutex)(&pf->sw_mutex);
>  	/* updates the PF for this cleared VSI */
>  
>  	pf->vsi[vsi->idx] = NULL;
> @@ -466,7 +466,6 @@ void ice_vsi_free(struct ice_vsi *vsi)
>  	ice_vsi_free_stats(vsi);
>  	ice_vsi_free_arrays(vsi);
>  	mutex_destroy(&vsi->xdp_state_lock);
> -	mutex_unlock(&pf->sw_mutex);
>  	devm_kfree(dev, vsi);

This also extends the critical section, as devm_kfree() is now called
while holding pf->sw_mutex.

Could you please clarify why this change is necessary?

Thanks,
Kohei

>  }
>  
> -- 
> 2.53.0
> 
