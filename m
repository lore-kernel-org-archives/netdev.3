Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18661370AC2
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789526046; cv=none; b=DOuq2XlJmJV69G9G6ZAbzZyg7ir+i5DiAyI2yBhzmnwulmCz9BEZipv6Jvb4Q55lMyHFPqUiF0aNlMthHBMz3o/itZVeMFIBX1zsAOGb8qJf4Jn9Xsa8q5X/reMf4pQ0FnxrC04tXX9kd9yZhHpKpZX1kcUiYJuvKCLEcnWqZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789526046; c=relaxed/simple;
	bh=9vwvkg1VbmktEcwPNR1NNNfVsKJ2wHJtwMRw2CM/8bA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=JFsXKo7bSAAWFi6J/8zQyg1fhxyP2KqvSGvBQq4J6MXv7+CYwVYG3JWT0jjQd+letzw/Z/6yVFh+CUiYfQQdUalygJN3VZbcczutjBI3Vj+1RyLXTKnCY+My3Z9I+bMUO7fa5ceb9BON3JGAbtXt6zmerRAAFvXNPKvcnYioVpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync7t1789526022tce0ade4b
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.233.172.177])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3370421215376934502
To: "'Jacob Keller'" <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	"'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	"'Sashiko'" <sashiko-bot@kernel.org>
References: <73D0D3F5D96A6928+20260914080020.211580-1-jiawenwu@trustnetic.com> <37ddac74-f30b-4143-966f-3c26cc9db323@intel.com>
In-Reply-To: <37ddac74-f30b-4143-966f-3c26cc9db323@intel.com>
Subject: RE: [PATCH net v2] net: libwx: fix races in Tx timestamp handling
Date: Wed, 16 Sep 2026 10:33:41 +0800
Message-ID: <029101dd4583$c9a837e0$5cf8a7a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQHEupbxOnWfIDN7zeIbToYlO3bclgHxZmZetvH71iA=
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MeJ9CkOc98pzjt1UUkgWVgsP+eM56xhhcDOn8P6Alkd6j+OIQ5G7cZ16
	6fiA9t++dpYCfaVjlYhmKrovUwcJvLliTV7TyJKtPa9+GyDxIrtKiNVWdEmtCaHi2V91c2C
	tFp1izLeSZLSHH6v2UozUNEd9JKQhMiM7/xKXGWqs7909QfSiCs94/TKPDoApm27W6OQT26
	+Kmy/tN7tW+0yfFtVqqnNowAPqLIy970B6vrYim+Aa4HmCyFXUSqQOQZLzYCBc7aLCcuZsq
	XPHG6JElar5VyZPhrE8bqRlQZglj2IeOEpoHJZ9tD9uso/fygTSYOiqghGMrnimczk1dVpc
	hSYcMQt5Kd8QnXhTaxKczUtesFsvhmeIz10n9frdJ7brBO3MZMggfcWe/OHyXrpf0jplcRL
	xj+kvRRVcN3U04VicYdGPwKtxCcX0CcMZlRskMNtY4wTnQwrvc6g6OmPJ6AiqetNbbnJWJr
	mi2sGJyf4VQE8PDjwCeZqCKvjACA63htsBz9HJD1p3r/EbS1f4ZIBWvUic/1EAjyqA9alEv
	xkOYI02xQaw4d2A33fm+Wyp44whcQRQJxnPQ7XsOSJS770LxXFLZPy5gQwH8bzakrFkYDV9
	/HgKxPdWgvJVATIVj8vYY8rTfjIWS2tYurbuhKqyldI5AzFu1+LEaXhBjboHuztGcmOOAwT
	wX+t/eFYigmO6H/sPMRtHpL/+BlI8K2UVq44CjcefUB4Uk2afA7B7wIy47UWQfDvEYaOAJ8
	XlrN9iM0oE6Ui5oz42k+dD7rv2ilwmp87DCMMOyaCsHO630el3nj7S0DZLPPlRnjRilhl47
	mDk5S2+5EDLijwp0mecKOk4Vy0iSKIO/S9j9WcOCUOfY+MsCJKM05jEsZkJTtYqp+UDfhHA
	arvHmzmGegyDhs6/r361ayU+VLyuEFFjVQitVl5mtZMBaf5MJpkrNPb4jPAwsMhbLKFAFOC
	Ini4oWj2GxxeN87UMNLOHomYzD4CX+MgIhXFkiZi/dym7vsZyjLFUPn4IoT9KJosItR5iZx
	Q9htBtj4yDqd3ySU5CBo1sGKsVbpzx9CxS8CNAt/fvvWdT8lPI1045qq3M13JWgNGPhhdC/
	Q==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On Wed, Sep 16, 2026 7:51 AM, Jacob Keller wrote:
> On 9/14/2026 1:00 AM, Jiawen Wu wrote:
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index ed5aad7857bd..940ba2c6150f 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -1677,19 +1682,34 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
> >  		wx->atr(tx_ring, first, ptype);
> >
> >  	if (wx_tx_map(tx_ring, first, hdr_len))
> > -		goto cleanup_tx_tstamp;
> > +		goto out_drop;
> >
> >  	return NETDEV_TX_OK;
> >  out_drop:
> > -	dev_kfree_skb_any(first->skb);
> > -	first->skb = NULL;
> > -cleanup_tx_tstamp:
> > +	/* The hardware will never report a timestamp for a frame it did not
> > +	 * transmit, so drop the request. Only do so if it is still ours: the
> > +	 * PTP worker may already have completed it and a concurrent transmit
> > +	 * may have submitted a new one.
> > +	 */
> 
> Could you explain this a bit more? The hardware doesn't report a
> timestamp if the frame didn't transmit.. but you say here the PTP worker
> may have already cleaned this up? How goes that work here? I guess
> clean_tx_tstamp label may execute even if the timestamp has actually
> happened and already completed? I'm not quite following this logic.

I think I was somewhat misled by the AI, the comment is wrong.

The label is not reachable for a frame what was actually transmitted.
It has only two entries, and both are before the frame is handed to the
hardware. No timestamp can be latched for such a frame, so the request
has to be cancelled. That part of the comment is accurate.

What is wrong is the reason I gave for the ownership check. The PTP
worker cannot have completed the request for a frame that was never
transmitted - it only consumes the slot when WX_TSC_1588_CTL_VALID is
set, and there is no new latch without a transmission. Bringing the
worker in there is simply incorrect.

I'll fix the comment like this:

/* The frame never reached the hardware, so no timestamp will ever be reported
 * for it and the request has to be cancelled. The slot is shared, though:
 * wx_ptp_clear_tx_timestamp() or wx_ptp_tx_hang() may have dropped our request
 * request already, and a transmit on another queue can have claimed the slot
 * since. Only cancel it while it is still ours, otherwise we would free
 * somebody else's skb and release their in-progress bit.
 */

> 
> >  	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
> > -		dev_kfree_skb_any(wx->ptp_tx_skb);
> > -		wx->ptp_tx_skb = NULL;
> > -		wx->tx_hwtstamp_errors++;
> > -		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> > +		struct sk_buff *ptp_tx_skb = NULL;
> > +		unsigned long flags;
> > +
> > +		spin_lock_irqsave(&wx->ptp_tx_lock, flags);
> > +		if (wx->ptp_tx_skb == skb) {
> > +			ptp_tx_skb = wx->ptp_tx_skb;
> > +			wx->ptp_tx_skb = NULL;
> > +			clear_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> > +		}
> > +		spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
> > +
> > +		if (ptp_tx_skb) {
> > +			dev_kfree_skb_any(ptp_tx_skb);
> > +			wx->tx_hwtstamp_errors++;
> > +		}
> >  	}
> > +	dev_kfree_skb_any(first->skb);
> > +	first->skb = NULL;
> >
> >  	return NETDEV_TX_OK;
> >  }
> 

