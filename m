Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB73C4578
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334493; cv=none; b=ojHOfPm8AnsA1eoWk7t/grjnksmUquqwGpwADf3ZixfjJoDenYod7+bNJhMwl7HiX38kxwkvRFqax7onK1bMF7k7n6UDOQ2Weo1Y1h0+kjYBbZSUSggRl4xe7aNDHc2QlHoIAg/4bUCZBYBW2zOuNyB2SWZU80bdfw6LBhxT2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334493; c=relaxed/simple;
	bh=jMSYTth2MtVkjELwze9IuNj1Dx0AhvZ4KljfDfNUjV0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=iRuNKK2WRTcX+WZhO7t6uDbk0YtfnFvsZW9tifp/y1S4EaJyKnspoJr7ZyR4ZuRMhT36eDl06hFaT3vC/nb+I9oGtV65NG0cgOc1uprTI8WCcot4eni3J+iHbczP8Gvd6BXzZCDUF7LL/WnYayZmn2I/guXdXuzI6rzl09RVU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1774334416t438t55879
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.241.114])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2448427198128428199
To: "'Paolo Abeni'" <pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<netdev@vger.kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Michal Kubiak'" <michal.kubiak@intel.com>,
	"'Joe Damato'" <joe@dama.to>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Abdun Nihaal'" <abdun.nihaal@gmail.com>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Michal Kubiak'" <michal.kubiak@intel.com>,
	"'Joe Damato'" <joe@dama.to>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Abdun Nihaal'" <abdun.nihaal@gmail.com>,
	"'Breno Leitao'" <leitao@debian.org>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com> <20260317073827.4300-5-jiawenwu@trustnetic.com> <911c9f2c-ff15-4539-9295-94475b969b2a@redhat.com>
In-Reply-To: <911c9f2c-ff15-4539-9295-94475b969b2a@redhat.com>
Subject: RE: [PATCH net-next v5 04/11] net: ngbe: improve the reset flow
Date: Tue, 24 Mar 2026 14:40:15 +0800
Message-ID: <048b01dcbb59$12c201a0$384604e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIBniu7DIOxO1rJ7Ea59Yh+/ilLigHZBRZLAeA/MtC1VV00MA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MHxrkKqRUYqX48/Lencg9Lp/kJw+tfOwOoJ+l6e+zCp+iXmBILwVeRic
	emPy79Pjdb1qZfZyIH7va1wJu/ZeAGQuue7UejX1/F/LRmiTZJK0LiAU7ertIB9Gf5Sg2gv
	Zd+gVo/Qpme7/yYt7Af/icyixCawpvAd1to0/sw3KG3NmNG/BoTj64ezhyKzbmMOZ8b/ODN
	3IbZPdROyu5VEYylVEvjfX1g1y3C3vLAdR/8esG+epxUt7HyYIeIiQQcbEWddfp1HHTwHGB
	7FE8WQUQHmYh/eqLhrfH9r5RAm2mmRiNNQ8g3vCpg+QCSOfPGJhCuBdUyGzrjwysRC/lqoc
	+z/If/zIodJU2Vv26xTuV9lZl9f52RUdwwtRlqqvvYovmsufl1sEj0eVXLbBqFADhTnUJT0
	DFZEMMrUwNNob0HqxnsiGlT7DgIgHdXgfAEPYgprb0K6fm4G0d878y66T8wkiEyZuDJrSgK
	/G0U+L1ewnAPiaI5sGbiNOa1d+0nP3Q9UdTf2xFb2CkPAG6SHdw6PxQutJX9B2uQrRn5P5e
	RtjER4kM8peyiptymHWxp6QajSF6PtlmczK7fhhxh8Iw6dBt7uoFEr+3t+lSO25rP04ol9t
	BODgKITMUXmuXTYP4p0QYz8iooGznnRrDuFZZkoYuxHa8FNh1Jpy3AmGW1GVIMBNcgfAZL2
	qAcN/yRIUSKS4a1C5QGDm0i7Q+8XvQNwxhZvADU1JYBydDchW6WaJf5jGAbVHI6Wvk/IOxB
	iMhXoO3ApAmed5/IXeEIWereVYwYC9GJsB7jcET8TdRsYE4M6ajDf6NZ2XemUp+7s7Ho5Ba
	WTOxQUV8AFwH6V0z5BxActjB5j/afvbFmezFOiHUCO+fT/SwuW2ERtOmrh9X05+I6SmpVsY
	WEfa9nIqbeH18tRgROA4uC4jKuul/wdL1EYB/3QRnXQAp/YjYRVP/gIJ+jzecugjsGzttpC
	tFE5jJH4cm1MWmvKQVwb7L+jWCF0lGxfrkxl18GzeEJS3Dfc/8VwZrNgwnEpSfRTVvoDrC8
	10IP/ccVCcE56UdMR82Pd+rM7SL+EQcfs6NQmKgOtXRhhfCS40YFLgVoJ/GXt35clibwgdC
	ERdHFwvUhbb
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On Thu, Mar 19, 2026 7:26 PM, Paolo Abeni wrote:
> On 3/17/26 8:38 AM, Jiawen Wu wrote:
> > @@ -383,6 +384,12 @@ static void ngbe_disable_device(struct wx *wx)
> >
> >  static void ngbe_reset(struct wx *wx)
> >  {
> > +	int err;
> > +
> > +	err = ngbe_reset_hw(wx);
> > +	if (err)
> > +		wx_err(wx, "Hardware Error: %d\n", err);
> 
> AI review says:
> 
> """
> Andrew Lunn suggested in v1 review that ngbe_reset() should return int
> to propagate error codes to callers, rather than just logging errors
> and continuing. While the response mentioned hardware errors are
> handled in another work queue, should the callers (ngbe_down,
> ngbe_setup_tc, ngbe_do_reset, ngbe_resume) be able to detect and
> handle reset failures?
> 
> Reference:
> https://lore.kernel.org/netdev/4ddc6f7d-ee6f-48a9-857f-a10448815675@lunn.ch/
> """
> 
> There are a few problems with the workqueue approach:
> - AFAICS the workqueue is scheduled on xmit timeouts, which are
> apparenly not directly related to ngbe_reset_hw() failures
> - the worker try to reset again the H/W and unconditionally clears the
> error status, even if such reset fails.
> - ngbe_reset_hw() is supposed to stop interrupt generation; if it fails,
> it looks like that the sequence:
> 
> 	ngbe_down(wx);
> 		// ngbe_reset()
> 	ngbe_up()
> 
> can have very bad consequences (like ring reconf with IRQ enabled).
> 
> I think explicitly propagating and handling the failure here is needed.

To be clear, when ngbe_reset_hw() fails, the hardware is already in a PCIe
error state. In patch set v1, this error will be detected in watchdog, and
do PCIe recovery. But it was removed in v2, so the sequence seems weird.

In the current flow, I'll fix it to return int.


