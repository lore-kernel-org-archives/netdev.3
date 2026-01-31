Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5003093C1;
	Sat, 31 Jan 2026 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769843061; cv=none; b=tmv1mzwY9g1QaYKxi6FuTOiRyyr8ebMBSbX6YzTjc5zhOmSizEFyzsE89KFxv+lAPd8ht0B6TLh2OyQLsI3sgpmg+Q/PAggzxDaPIft5NwJLuyOdvoFc6Sa8SBFzt4aTvSI+cxtT5au5u55Rbj4XzqW1bI/oSomlLCn6in8xCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769843061; c=relaxed/simple;
	bh=6EWdvGFMeGOZ3ybmMF54CEgrpRbcZjIC0e7KxtUYD1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdsPO4Cz30eKKcebS8nr1ztIAzCiLlAWsaBvdqu8NFqkA2cgxVaaKb3VM6rMWhaQJz4CQy29LPuMnJrS4IGLlQmc8ed4NMs2RW93JcyyNByI0AZkZbUUYFwUOOUa4Yt54qXl4yHnT386HcfEs/sjSfgagI/TZOFPOdRPo5ti7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=DFLkZzag; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="DFLkZzag"
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60V73ZSS013433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 31 Jan 2026 16:03:36 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=9+22T3qAILLWnarXKk2rk2jH9okIYXXwV2PNBFUkk50=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769843017; v=1;
        b=DFLkZzagAsrFRi53NMETPhbWhcFfg4o9hcQnuMUXLA+1j4H5WwvOjBmv9eykxz5T
         jW4UkQWDIv0yMUtX7cCJmimqaWrj4WIBnkAI92WdByrBv4TyXcH8m9t10KgRqlPZ
         gehnhZxXZZGTayYdVsFSyM1NRhDOFiHR4/lSqYNWNjwhiytG9SSnXes38QxL7qDS
         obF5Rs+DGcWrwMzi+cR8+pBgExZOKFVCiSP2D/2wELUankdMn2dKpSDiLbQQEFls
         1dQlmUkmdZG0t+sMc+C3AqruS/u9w9a7hT4mBomgbSaG7+5EheuasQ4ZAW//4dQU
         ofR8nH7F98rogpqaFEHOLg==
From: Kohei Enju <kohei@enjuk.jp>
To: kohei@enjuk.jp
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, bjorn@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
        lihaoxiang@isrc.iscas.ac.cn, linux-kernel@vger.kernel.org,
        magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com, stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: add an error handling path in
Date: Sat, 31 Jan 2026 07:02:38 +0000
Message-ID: <20260131070335.38303-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131061304.27368-1-kohei@enjuk.jp>
References: <20260131061304.27368-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 31 Jan 2026 06:12:12 +0000, Kohei Enju wrote:

> On Sat, 31 Jan 2026 13:52:17 +0800, Haoxiang Li wrote:
> 
> > In i40e_xsk_pool_enable(), add an error handling path to
> > prevent potential memory leaks.
> > 
> > Fixes: 1742b3d52869 ("xsk: i40e: ice: ixgbe: mlx5: Pass buffer pool to driver instead of umem")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> > ---
> > Changes in v2:
> > - Add a Fixes tag. Thanks, Paul!
> > - Replace unmap with i40e_xsk_pool_disable() to prevent
> > a limbo state of queues. Thanks, Maciej! 
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..a72a309540c3 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -108,23 +108,26 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
> >  	if (if_running) {
> >  		err = i40e_queue_pair_disable(vsi, qid);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  
> >  		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  
> >  		err = i40e_queue_pair_enable(vsi, qid);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  
> >  		/* Kick start the NAPI context so that receiving will start */
> >  		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  	}
> >  
> >  	return 0;
> > +
> > +err_out:
> > +	i40e_xsk_pool_disable(vsi, qid);
> 
> I think return err; is missing...
> 
> Also, since i40e_xsk_pool_disable is not declared before this line,
> compilation fails due to a 'Call to undeclared function
> i40e_xsk_pool_disable' error. Adding declaration or moving
> i40e_xsk_pool_enable() after i40e_xsk_pool_disable() is needed.

After skimming the code, I think i40e_xsk_pool_disable() can fail in
this error path, right? 

Let's assume a scenario that i40e_queue_pair_disable() succeeds but
i40e_realloc_rx_xdp_bi() fails in i40e_xsk_pool_enable(). 
At this point, i40e_enter_busy_conf() called by
i40e_queue_pair_disable() has set __I40E_CONFIG_BUSY state.

Then the err_out: path is executed and i40e_xsk_pool_disable() tries to
call i40e_queue_pair_disable() when if_running.
In this case, i40e_enter_busy_conf() fails because __I40E_CONFIG_BUSY is
set, and finally xsk_pool_dma_unmap() isn't called.

Do you have any thoughts on how to handle this case?

Thanks.

> 
> >  }
> >  
> >  /**
> > -- 
> > 2.25.1
