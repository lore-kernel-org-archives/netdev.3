Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E12848BA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366403; cv=none; b=FdCkFn7mEe6b91nMiUcxRm7q7VMe9FPkL2vtoaYG+Ui52Hw1UWq3V3H6zfw/pLAu3/gw3lPnFhg1lAbq1YlTbBuxjacrm4voNFpDCCKrSyne/EBnawU1PZPVdun8FUmSmzGWqA+KXAjewJa/ILstSTnAhzMc2/iiJEHr76Ud0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366403; c=relaxed/simple;
	bh=t96XXTrqZwco/ZkN4JS01QjTUI1n6trfRiYNOt+Gt8M=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2iJJNyJmrWSzvmLTCQPsrxlKl2faFBUjgA4MKYVmcKscv7DYrn22wbOq4tko5lIkphvYusKsJG7xuWhMidjEFgKwH09202ibLEt76IK5lNF7KZjiKwjNvgEIXp6elhMTteHutZoCdUWpTSC764N+xZ9sXTgsSi65nkzl1OqfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1780366340t795t39840
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.207.111])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13029302356404573232
To: "'Loktionov, Aleksandr'" <aleksandr.loktionov@intel.com>,
	<netdev@vger.kernel.org>,
	<netdev@vger.kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Keller, Jacob E'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Zaremba, Larysa'" <larysa.zaremba@intel.com>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Johannes Berg'" <johannes@sipsolutions.net>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Keller, Jacob E'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Zaremba, Larysa'" <larysa.zaremba@intel.com>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Johannes Berg'" <johannes@sipsolutions.net>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com> <20260601072221.2952-5-jiawenwu@trustnetic.com> <IA3PR11MB8986350DE4363EB91F97F1ECE5152@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986350DE4363EB91F97F1ECE5152@IA3PR11MB8986.namprd11.prod.outlook.com>
Subject: RE: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce callbacks for AER recovery
Date: Tue, 2 Jun 2026 10:12:19 +0800
Message-ID: <088e01dcf235$3dabf3e0$b903dba0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQEmZmPiFxLXVQw6wm5cjAUm9/PfJgGkmD0MAkd9jI+3eDebsA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M55hJWV3AvyxI7OI/YhhEBLqFoi+agqjIgjPaK82XghqA+z6cx9ufo7v
	9GLUQr+uljQobqT8ulxAVbpIBkdbKptzbOfzluviB07QnXsXXTE+c+/nscVktf+qQ1Rlydn
	xwCfA3gavBdOazbIbpgtwO1d4cQC2dtAf/PqiwVrzFfruHTLkjk95QdGRsvyv7oNqNEobpr
	PSyeXXNqVv/hm/XiCkJtvs4sjjCjvw9JgybkZE+JK4/i1Aqg8JBoiiXqBm7P0VJCBUw+wJZ
	3bYvuRMOQglTkf982rB3r9xynC5qGIlEAfXzQtMOOOgqf3r2IcWJNAvSNpd6BEWJIJgo1RV
	/MZ/aoFu/WGGcXJSn5ZDrvV3vKdiM5Mu3KmVHek8I6nIry75j3G0XFABHlMLwIP6XPzRYn0
	+PdST3bTBl8zFO8xj6UTtG92kZtGZeO+xKpBtCQBLVZTYlmUcLHumPvBPOL6AN8T9usUyTG
	0Ofrz5NbYzjQWazUFG0maUcenkiEwVd4/i64tMq73ZS+i0AVNhCbicRfq+4pmUNZpUlEqaF
	SqNTt2he5SZGnhAgQ2LxaWozDiS4yI/bBvmpTRvPtW/hJ59H8RdVC42+Xc4lVNCyIflMbnM
	XVel4AdD1FcmWfowiLMiF+ELWx5NeoS0C+LsWKItx33JF0iDAlyuG8klWJvhSJCOleLFdhD
	+PvDHNF5dZPuh7eAl7fuxJza8QPyuW3lZUK7ENJGs7afRr5vNeiJ4RjbZgNCQYOQ/yMjcVE
	GHkc7Lkx9MGy1mUsltfCZBqrFGOp6iP7yRGW+mYCV/GfTSxXysaRyS53H3c9UNZ9iWBcxgA
	NjXMCwTs3FONrJcC24OUx8jfFYdg3uSm3J+Oy9DJoS9BaOAKBjVyoy8307hV9RT72J/5TLD
	lehMhwMM73jX0XXsOv6nSjhX/59r+m87QhajHOz6j6WpNSJ5PY9E8hy9ad7Fq38fcjnoIPA
	50fyaLHQAag/sCnM1Kvq7+vdEvvFwnI86d/u3YmL1ThYjKp1wT/y8TWtK3RtjNpBL+/z1DB
	wqvtyqd74CNm8RA89ahdpnRAtK/jsQz4RMz3d1CZ0VEe00TfonukrRuyUAfeg5EC2pJwTqh
	Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

> > +static void ngbe_soft_quiesce(struct wx *wx) {
> > +	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> > +		return;
> > +
> > +	wx_ptp_stop(wx);
> > +	phylink_stop(wx->phylink);
> > +	pci_clear_master(wx->pdev);
> > +	wx_napi_disable_all(wx);
> > +
> > +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> > +	timer_delete_sync(&wx->service_timer);
> Can you exlplain how do you handle service_task work item that was ALREADY QUEUED before
> timer_delete_sync()? Because they are NOT cancelled here.

Waiting for the service task to complete may unnecessarily delay PCI error
recovery, especially if the work item is already blocked by the hardware
failure that triggered AER. The service task is not explicitly cancelled in the
AER quiesce path.

The device is marked WX_STATE_DOWN before the timer is stopped. For the already
queued work item, it must check WX_STATE_DOWN at entry and returns immediately
without touching hardware or driver resources.

I think what I need to change is to add WX_STATE_DOWN check at the beginning of
txgbe_service_task()/ngbe_service_task(), just like wx_update_stats() that has
done it.
 

