Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B323741
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067734; cv=none; b=jjsD924h9VKE1pPj6K3gPIlfuydDZPmbIs7MyhldisY04XjN9raCjVU30cmUMUy72fW7T5YJMGOL36TFnmMgp5krUJzWufnilD7L0fC7w6U6/JQ61BcSIVTarJaiHb3KHFZVZmirJeHc70gu+MviDWcIcPIXjWqSXz526TBsylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067734; c=relaxed/simple;
	bh=pacRcA8W1tWwSgL9a07u5fSoSJzl+fbdFfO33FuVV1k=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=j/5VDyktmB75a7pJ6A97+qDaGBRVj9SsUiGUekffkHWKTrPDc3Uk0Pqb/HbmNHpORRmDP06UgOX3jWexPSd24wdFqeER6bsfSFxmGgtacaMyvksWRvQMFiTbJUvFAdW4vw96VTeKH7Y8uRWdD2k/U6Fwcjg7fG4C2fFwGzGFXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync2t1786067632tb37c38a6
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.196.25])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14464708908423724219
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<joe@dama.to>,
	<u.kleine-koenig@baylibre.com>,
	<weirongguang@kylinos.cn>,
	<larysa.zaremba@intel.com>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<joe@dama.to>,
	<u.kleine-koenig@baylibre.com>,
	<weirongguang@kylinos.cn>,
	<larysa.zaremba@intel.com>,
	<horms@kernel.org>
References: <5FE44222ED3FAC4B+20260803072022.377406-1-jiawenwu@trustnetic.com> <20260806153138.2580692-1-kuba@kernel.org>
In-Reply-To: <20260806153138.2580692-1-kuba@kernel.org>
Subject: RE: [PATCH net v2] net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling
Date: Fri, 7 Aug 2026 09:53:51 +0800
Message-ID: <077e01dd260f$983c0c60$c8b42520$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQG+uWkNEl0QLst9yGJ3EcEY63s4ywEjyRTmtsWKkgA=
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NvxNySBpH0Ql6jlTvvgclVeH77aTpjdOHrb11CSv9Bpy5K5VfyxZWzI9
	qOsTuvW5dzXPubWDWfqBpXLoCUkqP4Eucfcc8P7mIfzSxtds6vZyjFmmG2bGRKCJU3wfIiq
	Oly4yxi5SdD+yKIMXWFF0j8fQgMykrpQZdQft2aDeqf4OhmBclcYU3SMphdvWel+ZPVQtx+
	b/2HHeu3wC/RT0YuiOlScA8mAhIETL4X3JiTkIK4q+KqWSEwTj22FccJL0sJlbI82GgJhnb
	zkk5QxXYOfoXXT4zQwFTPjiu3KCInhDnjoO81G5baL35B64WYAoplxzTTu8rxO8Mq77JtY/
	YdKAKXcoP98qGJC3SadOpARr4T1vLTTHO1/bGTZg/QEPcJkuoB+ifHCbEv12PqCDhZs7KKt
	pLYyHGJnPbW1mMHnj6T2gaLXYaIMam5/e3K3er6cLaACsoFpU1mle4Ud/Tys+8Jgm0/xKSj
	QK4Rx4QWL2tMdrifxTCXhDQvlGjDGysYgRwA81wijgSu6e+lvM5Ub7diITA5cj/q4pH07XT
	iOBjdvA3rl+FgGVkFsUenbnCjiylqWo+IWWomtHPrhGz85w/3Mwxa8+LUGNVTUjCW03ZCrT
	QHVMPOnAzWXZX5w6UJBht/fnQ623cHjpVpcgosmv1SCcXQZh3icdfVgVnfmBs0pOfx+XfHy
	q/yDXbnaZvLrMkC43/QgEaGJeDB+pHYYv/rktO6VTIDIYFua7YRvLboUE+jPVecXWeVV7eY
	Fj/5gyjK7ZmuGo+LNa35hk1q9yM5zkdmW3qmLJbyDmx2icpi3GoMUYX+M6LaVfbW5FCjC6p
	nfzoJTxj71o0HvmjXn+jzF6zBTW8wyTRGBdR3lxt0jTEqpFzgXOpd8ccaemOA7HnFy5ikqi
	RLS3nIMwyAlGr+OoCrNpUJZfFvi4TNB2seNSA6jWlmERrWka6iyLPXUgKKWEjI1kdYabTgg
	WSVNEsk78SFnFsQNS2LBovFzJP4aJ8r9bhrqoU1pzaqeLcpQsicCpKns9ajdmJQSkJ8aZuC
	BMFgYnJ1EQ8Zw0LV+IvO+8idgGaeu/94a9ObxlHQaaNP4+E4aSerUMnLo4CFosHeVNlPxLT
	A==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On Thu, Aug 6, 2026 11:32 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling
> 
> This patch avoids dereferencing wx->msix_entry in NGBE_INTR_MISC() when the
> device is not running in MSI-X mode, by testing pdev->msix_enabled in
> ngbe_irq_enable() and falling back to a hard-coded mask value otherwise.
> 
> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > index a16221995909..cb653861aad8 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > @@ -180,8 +180,10 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
> >  	/* mask interrupt */
> >  	if (queues)
> >  		wx_intr_enable(wx, NGBE_INTR_ALL);
> > -	else
> > +	else if (wx->pdev->msix_enabled)
> >  		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
> > +	else
> > +		wx_intr_enable(wx, BIT(0));
> >  }
> 
> [Severity: Medium]
> Is BIT(0) the right mask bit for the misc cause in the non-MSI-X case?

In the non-MSI-X case, the MISC and queue interrupt share the vector 0.

> In the MSI/INTx fallback, wx_set_interrupt_capability() sets
> wx->num_q_vectors = 1, and ngbe_up() -> wx_configure_vectors() still
> programs the misc IVAR:
> 
> drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_configure_vectors() {
> 	...
> 	wx_set_ivar(wx, -1, 0, v_idx);
> }

The register WX_PX_MISC_IVAR is only valid in the MSI-X case.

> with v_idx == wx->num_q_vectors == 1.  wx_set_ivar() only forces the
> other-causes vector to 0 when WX_FLAG_IRQ_VECTOR_SHARED is set, which
> happens for wx_mac_em with num_vfs == 7 in __wx_enable_sriov():
> 
> 	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
> 		msix_vector = 0;
> 
> So in plain MSI/INTx the misc cause sits at bit 1, and bit 0 is queue
> vector 0.  Does this branch then clear the wrong bit in PX_IMC, leaving
> the misc cause masked while unmasking the queue cause?
> 
> The queue cause looks like it is meant to stay masked here, per
> ngbe_intr():
> 
> 	/* would disable interrupts here but it is auto disabled */
> 	napi_schedule_irqoff(&q_vector->napi);
> 
> 	if (!test_bit(WX_STATE_DOWN, wx->state))
> 		ngbe_irq_enable(wx, false);
> 
> and wx_poll() is the place that re-arms it after NAPI completes:
> 
> 	wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));
> 
> Can unmasking BIT(0) from the hard IRQ handler let the device re-assert
> the (possibly shared) INTx/MSI line while NAPI is still scheduled,
> leading to repeated hard-IRQ entries and, on the eicr == 0 path, to
> IRQ_NONE returns followed by a full NGBE_INTR_ALL unmask?
> 
> Would BIT(wx->num_q_vectors) be the value that preserves the behaviour
> prior to commit 4174c0c331a2, where NGBE_INTR_MISC(A) expanded to
> BIT((A)->num_q_vectors)?  The sibling driver still uses that form
> unconditionally, including on its non-MSI-X path:
> 
> drivers/net/ethernet/wangxun/txgbe/txgbe_type.h:
> 	#define TXGBE_INTR_MISC(A)	BIT((A)->num_q_vectors)
> 
> One more note on the changelog: it says the fix is to check
> pdev->msix_enabled "to determine the correct vector index", but it does
> not mention that the mask value written in non-MSI-X mode changes from
> BIT(1) to BIT(0).  Could the changelog spell out the intended vector
> index for the MSI/INTx case?

I'll add a log to describe this in passing fix. 


