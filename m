Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD57352C4F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557998; cv=none; b=hGvYj/mfy4Pz9JATPH1WotNuEBU06JMzRO0qls4iN0atihNOl4yVyiMuhBoTgCJ2SiC2IKsPtIkpvnxOD/WO4LVPrPNSulgDPG0I+X+YwliBiEfVDBS+4WEgxQ9MTgyfW/+KDfHq0yRYpuKBXmpEWnBgu9TN0Dehce+MHw8V9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557998; c=relaxed/simple;
	bh=qfrFJW3AJ9iJ6i27LMZMOr/QdBCVBvO7g9eisgLV3WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xahc68scNfSSP5awJRQ6dlhQK4SQDjh96MFV949joCOfKNJZCgjB/Cw8XnUSTHwFoLDdQQkhyawFuYZGnwcoDSIT+J0Ae2DvhTfP51kvST5JiN+KUZgO6TEv539nU5lYePkW77FPh0WpAYToRDCF+1AMAVHRBUIql9hRM9+eCR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NlHWVgkP; arc=none smtp.client-ip=95.215.58.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NlHWVgkP"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qfrFJW3AJ9iJ6i27LMZMOr/QdBCVBvO7g9eisgLV3WM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790557994; v=1; x=1791162794;
 b=NlHWVgkPhZoRCZ9CGCLlxD43QiA9RyrgP/Iy3XOa/eWeRterYgp6mR0xyv16yD9L2N5iFM2P
 FW9pYBv2lB9hRDWoBQIbI6JDarQnoK6YvLdtzHdA+nRPckTbnmD2+Yx1TMl19jYXhzD9FrLmezp
 RIeztihLUmI4XpuQPRPnOX+Q=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id b0d8cde6a6540824;
	Mon, 28 Sep 2026 01:13:14 +0000
X-Mizu-Trace-ID: b0d8cde6a6540824
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 09:13:05 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: pktgen: return bool from
 __pktgen_NN_threads()
Message-ID: <arm_BZyS7Nf8N1AP@fedora>
References: <20260927135406.3969970-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927135406.3969970-1-nicoyip.dev@gmail.com>

On Sun, Sep 27, 2026 at 09:54:05PM +0800, Chengfeng Ye wrote:
> Callers of __pktgen_NN_threads() only check whether a pktgen_dev was
> found. Returning the pointer exposes it outside the helper even though
> neither caller uses the object itself.
> 
> Return bool instead and keep the pktgen_dev pointer internal to the
> helper.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v2:
> - Rebase directly onto the current net-next tree, independently of the
>   deferred RCU lifetime fix.
> - Update the commit message for the current helper implementation.
> 
> Link: https://lore.kernel.org/netdev/20260825185313.239861-1-nicoyip.dev@gmail.com/ [v1]
> ---
>  net/core/pktgen.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 7f81aed46672..a89cb0760821 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -2024,11 +2024,11 @@ static const struct proc_ops pktgen_thread_proc_ops = {
>  };
>  
>  /* Think find or remove for NN */
> -static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
> -					      const char *ifname, int remove)
> +static bool __pktgen_NN_threads(const struct pktgen_net *pn,
> +				const char *ifname, int remove)
>  {
>  	struct pktgen_thread *t;
> -	struct pktgen_dev *pkt_dev = NULL;
> +	struct pktgen_dev *pkt_dev;
>  	bool exact = (remove == FIND);
>  
>  	list_for_each_entry(t, &pn->pktgen_threads, th_list) {
> @@ -2038,10 +2038,10 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
>  				pkt_dev->removal_mark = 1;
>  				t->control |= T_REMDEV;
>  			}
> -			break;
> +			return true;
>  		}
>  	}
> -	return pkt_dev;
> +	return false;
>  }
>  
>  /*
> @@ -2049,7 +2049,6 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
>   */
>  static void pktgen_mark_device(const struct pktgen_net *pn, const char *ifname)
>  {
> -	struct pktgen_dev *pkt_dev = NULL;
>  	const int max_tries = 10, msec_per_try = 125;
>  	int i = 0;
>  
> @@ -2058,8 +2057,7 @@ static void pktgen_mark_device(const struct pktgen_net *pn, const char *ifname)
>  
>  	while (1) {
>  
> -		pkt_dev = __pktgen_NN_threads(pn, ifname, REMOVE);
> -		if (pkt_dev == NULL)
> +		if (!__pktgen_NN_threads(pn, ifname, REMOVE))
>  			break;	/* success */
>  
>  		mutex_unlock(&pktgen_thread_lock);
> @@ -3835,8 +3833,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
>  
>  	/* We don't allow a device to be on several threads */
>  
> -	pkt_dev = __pktgen_NN_threads(t->net, ifname, FIND);
> -	if (pkt_dev) {
> +	if (__pktgen_NN_threads(t->net, ifname, FIND)) {
>  		pr_err("ERROR: interface already used\n");
>  		return -EBUSY;
>  	}
> -- 
> 2.43.0

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
