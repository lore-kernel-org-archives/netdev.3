Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C11CF7D5
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170785; cv=none; b=KF/zvxc+ReiycZo65flrfrZre1oWE3BH1OKVhLsCas0rFfWpCm3C3+zF42tCOKYvaaU/k+6tyvvpovK18q4VSSgRZ67UNogRxILpjtOFNO+wxxRX3FO5CqsBI7nT8TT0DYU8i6AruXRQ7MdP1x41n7bAJbFRn0HSklLRsiXqGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170785; c=relaxed/simple;
	bh=SQLcjY3EEEHVezLktYR6MLCzHI5pwKu0D2QQilGi+Xw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1np5ZJkJRldbUoF3Bw0HKqolcsLlANWHq19Vowu5KLgONpXsk9ZAw1EEccqLTpBDTNrVkDWYCWMBbmTDSD5PeArMIzXOgEPbC8hEGjn8X0tKB3e4v7TeenwWzPfH3seZ9yVvHYEgcguPWPK/e89x/CLOSUuuM1piwf0l+PyIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas8t1770170702t748t34615
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.47.234])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3142833660823124878
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20260203075759.5852-1-jiawenwu@trustnetic.com> <20260203075759.5852-2-jiawenwu@trustnetic.com> <c58edf64-c61e-4ea1-ae4f-8d5c15003019@lunn.ch>
In-Reply-To: <c58edf64-c61e-4ea1-ae4f-8d5c15003019@lunn.ch>
Subject: RE: [PATCH net-next v1 1/7] net: ngbe: move the WOL functions to libwx
Date: Wed, 4 Feb 2026 10:05:01 +0800
Message-ID: <06ee01dc957a$abe802d0$03b80870$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJleOpPEsmr23hemQ93knTonzMr0QKFOXnjAZLCM1y0P0NTcA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ml6rbZnL4VO3msEN7drUUNlGSVAKs1maqRBdXAyVpNGFxIvsPx0zRYiK
	wn1+n//X8uIiiNwYe237X2v28VXk1abnvlaTqRiUJRuBCNHOvXvkpqyulCHk9MhOrAkDXMs
	frFliMD4zfM6Rd887M4aU7SZZhJp6/I7q21qnAA8E9zY/dlg0GcC5GhmOfynajCdjHdvcIA
	AqvtOxWgvZbcwQPSVGPyqGj9OKa+16+Kkaf7nVByk3HURL4qNEU1XltaYu243fUFkcKoT/Q
	7zCE3stna8OuIgPcpD+tBere96qteedm30IBFRm/AZCUcolQouTS2G+u/LkMSjlM4K8Yi8q
	Lc87080+QWgtHURdPwQlevs1nf4Qh5aiKTowxVn13beUMtyDnUMAW2VJLHPTCgUKHptu0Et
	tjc9DEMTUJdskeBcYA8iy2d4Fm+dgekbvXlU6xS+nGeU5CURQBQHebNFrmOzIE8k785vJKq
	9oXuttl6KhcJV06WTU1hydTVI8L4IcBZnmJDXATLX4CcWnW4A7SM8ATVzsuWDfg0a+I+iZE
	MemrRh+KteMQZ5ciiBH2HMWKFv19IYjUkJv4u5G8J5vnEOkzGt5UYJ52VcGSYqF0q1vpaHL
	eDfp1KxNwDlLZpb9Ed4Q4yqxxoh/R/vwuj/Rn7ycOM9jSdfWgFnkk7QGwVd/ZfMSEpFQGTn
	whkwQ2QTBUA6YGK1r6k2sR/CV5IEk0wGkbKC1f8b8LyAiWkDOYwJvDh7QRZj6gJ+npEiiQO
	YQNYT3tgn3qzYmWwTX62Pig7xfLmpwISGQZnIWj9eD2GPcnGLzY41m05NJMs1aawZEPUc1B
	Rd6pMZ/hauIciYGfcYWlI1TQIChvoZeeFA0E07uhdJS94xskznNQixu5G1nNj1LW2/e+e2S
	cGRdGQOYfN6gVWiR9Bud1lHV/LPpzYz2TcS5NaOD/nrxuIfAEvg65S3thdnasNrnGRvjzl1
	Dc9mD4ba3hq8uq861t7I2qw836lJ3c55wKxj6RY3qY74hZEX65Y9Z96N5ecpvI6R9WUyxWu
	goj7NmsFdb8I285T2G2zeJ4Tj+oUO4+QMJOF9hdJ7mKc9dqqj5HDLjxmZx3dImVmqH+NCCf
	ztqPtXt4I4Xb70qBIk9xe8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

 On Tue, Feb 3, 2026 9:53 PM, Andrew Lunn wrote:
> > -	ncsi_mask = wx->subsystem_device_id & NGBE_NCSI_MASK;
> > -	wol_mask = wx->subsystem_device_id & NGBE_WOL_MASK;
> > +	ncsi_mask = wx->subsystem_device_id & WX_NCSI_MASK;
> > +	wol_mask = wx->subsystem_device_id & WX_WOL_MASK;
> 
> The ncsi_mask change seems like it should not be here. This patch is
> about WoL.
> 

I'll split it, thanks.

