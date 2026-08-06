Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A153DDDB3
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006722; cv=none; b=PU6gYhfB7CPrWXv6wGiDjbnaG9+HUAVktzLEnipTdVpVACZQiSeYHfGYyXMj4Wcart1t4JWd6h8vAowUxUlTNcTjv8L+xC0XvEEnpREd0qc0KsvSQOyakoaEL9npvl4xtt0FmvRG6Dg6QTvy5gdrkh2MwO+TmPOwrxO3ANS9hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006722; c=relaxed/simple;
	bh=skU8MXVztSQdRdPHC3GEWLtJ6+9FpC2XldmKC2NFXsI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=IHq4h5xmXegrctdWcWAEJ3Guh5n/dkc1XTT9rZaOjeuEnd3MHYzOP3wG3ieqsHQ/45Ik8sQSQMPnNqRyUxSOahgNmxiX7NonsRv00CQws6AgR0bmZwf0j53aCjSrrCbtcYvIyQIwEdNqMteAJeeUI7zMKk6scxcOF1FqGt3tEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync1t1786006659t303ca78f
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.196.25])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14363196900620509808
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Rongguang Wei'" <weirongguang@kylinos.cn>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Chenguang Zhao'" <zhaochenguang@kylinos.cn>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260724101309.23472-1-jiawenwu@trustnetic.com> <20260724101309.23472-6-jiawenwu@trustnetic.com> <20260730131908.GB51943@horms.kernel.org> <04ee01dd2094$589e7050$09db50f0$@trustnetic.com>
In-Reply-To: <04ee01dd2094$589e7050$09db50f0$@trustnetic.com>
Subject: RE: [PATCH net-next v12 5/5] net: wangxun: add pcie error handler
Date: Thu, 6 Aug 2026 16:57:38 +0800
Message-ID: <06ab01dd2581$a1ef3400$e5cd9c00$@trustnetic.com>
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
Thread-Index: AQIS+4v0YnBoeMVdPoCsylDHc5O5qgHQvQ9rAQboc/gBnUwjhbYBYTKQ
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nv1Zs1ssfOILRk+tGXpbfQOxnnw7zXBHx8TA/UlS0Y9zLkXu5PHscAyq
	J4gZV5xURfo4ir5qUYnpMOdEV/S2PLeogaghcbGrkcK81rG4+86495QNRKyrncC3vc27SV8
	gHJ1Cvs8c/oqYq8Tm31ptovedVYFcDZvw/9i/Txk01TeiwdNA2bAV9NPDNO9RwY51YdcMvb
	x0J7dVsCxB+EQyzH190aAnoQlUXG80bDw4nlYajDD94C8wtSJirTEOeEQsr1E67o/u1ihqr
	3TTjvW8p1+GiiwTy7HvJF2eWGeAoSWTL2JZ+sm/EoeZGE7xG1DjQLAK+okCoaWQDxLpUCAo
	ELEjledMIKtVHP3hpUeso37KWKjBSHMT1L44byhMUwM7Rxo6DJ0Mc0DDEpeiZIKWpsHJX9M
	9UFWmmhLD4KC9/wmf3KE1rlNC1P2BcC26qBfJzxY4n+zVdUcWgBsEf4oQ4pAJRfzeCNWXDZ
	+Bgko6aB4cJO2x36yJ+9EusUH67c56uPS8uD11BA+DQIy9dGg35nYGH3sPh5dzYnIv2PW5d
	8LEm1ycqCZRidiL0yHTPW7VtzCfZfFEXoZFHC6aZ4wZlPFbyc6+XAdPA3/zrxfnAIZcIID5
	zgdyKAN9NbpZcC1jCA8HRmEYo6yAT6MnazhzabBTp/h/P2PUxAWcP8IgJ0yHGH/rnZw/iIB
	6GGG+LdfAIic8ZvSmydCoslihADom4Hj8JzoP/IUoLPjcJlb9Q6+wq8iAsRQYiMm8KmMEBP
	TDNtOOEVQb2EHubu/WhZNyhAbrMDhGxKwclDcdOjscmplvy3FgM9ziyHeJiaxasav4PwvIV
	Xou8vweMx8Bml8HHCdaiWQIQiTbjS8LIbi3F3B+iEzgbF8WsIby9M3FWm/qW97d2bvHD8c8
	10nbCB5/1YMrR/YSCC5NadVRXUnhDSzD/mAtc0k2IyBh02q/IMsfBeZ6FbTyTVa9zvTvo6m
	AYsqmkRo6QvvAfJ1s1v3gjo2ETgBYb293WvnYb9qOq6bpakM/rKu9vuAWn1QYNndsm7J1Kv
	+sBmULz0btkiganlOAZdM5aitb2Fn4Gvyyy/TCQ0yuIOIk6qdtjzAi6ZoAB/wvLyfoWFQpA
	+eTK44Vtj8P
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

> > Simon says: I think the issue below can be looked at in the context
> >             of possible follow-up.
> 
> I'll consider handling this in another patch.
> 
> >
> > [Severity: High]
> > This is a pre-existing issue, but does failing to open the device in
> > txgbe_open() lead to a NULL pointer dereference on subsequent open attempts?
> >
> > If txgbe_open() encounters an error, the error path calls
> > wx_reset_interrupt_capability(), which frees wx->msix_q_entries and sets
> > it to NULL.
> >
> > If a user subsequently attempts to bring the interface up again,
> > txgbe_request_queue_irqs() is called, which dereferences the NULL
> > wx->msix_q_entries array.
> >
> > >  	wx_ptp_stop(wx);
> > >  	txgbe_down(wx);
> >

After checking the code closely, I think Sashiko is overstated here.

wx_reset_interrupt_capability() called pci_free_irq_vectors() which set
pdev->msix_enabled = 0. And this would prevent wx->msix_q_entries from being
used in txgbe_request_queue_irqs().


