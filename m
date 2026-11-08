Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158661;
	b=HKf4L/UpnQdiLSn7xPfPE+HX6MB3gwtnES8AoG81ODLSrRfXKP2Pcr5cauFT4Go0mJ8y
	 xcbAckrt5/gENgXWQS7g7Sp36JbjxeCMygqO3xSX5hHJD2iJ4QkDxcdxwBs39uJTxM/ao
	 LkTwh3pkVYhON4DlN2EaLvhZ5YlKDfE3DA7J5+08RSfU3CQxmOm2wF0jSMwNCdDlSAVHr
	 ya3dnfm1NbVN70hKo03850LTRu1yFVd9rqat0hkWZAADe+p8CKmOw85XXAdNlPFM0cfpI
	 /PAwcND7d2TBGA0c+lOVRdIFabhoWXT11dtG4NrpXzsOEf/F8FLp4SnPXtjwqiGp2sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158661;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:In-Reply-To:References:
	 Date:X-OQ-MSGID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=ZtNLtbaEc7ASjOvddl1E/0CMF6y1uJvlTDfU9yqpSR4=;
	b=fARW+Zdu0oIfF6CPCahZKzyFbp00PYhhdXSCg6vk44v7ywa85VVZP9gMyJlWW6/4GOPf
	 S15NtbYq0mi0ps3deZjvUq25BXWUL2q9dlUefkB4OiYJu32LDIUaKpmxmFXKR3j3ceDGy
	 lawIMdUY5B1GjpYXSpSV8bOgwTJgQoXd9gcni1HaKExtumcUjddCTW2/s5arGuBQfYtzi
	 hvXx8MLOScWI9ufIXOuNpqQ6lSRZ8s7fvFieG7E1A3NaW2ogwCOWv9J3HiKh5JJbutWTq
	 Jcu6NQ8ckvhh6NYfKdnSrl6ypu2CWiQ5VOLxN66NPxBdqlVD6aKteI6gca9rt1d3dFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=etQJuSy8;
	arc=none smtp.remote-ip=203.205.221.190
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82027606A337;
	Sun,  8 Nov 2026 17:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82027606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=etQJuSy8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794158658; bh=ZtNLtbaEc7ASjOvddl1E/0CMF6y1uJvlTDfU9yqpSR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=etQJuSy8xDGyBxRrikGer70L8zyxqLXK5nnFi6ITWtDHtwVe/DHMeogZ902U8Olul
	 2QQXpSkTnGecMH1ehnKF8aI2OMoWBjftcaJ4TLY72tFHp1FOEWJ+JhhgOqGrD1V7e4
	 oPR3s404/+lnl2dUoPzawi1Xvd3Dv3HJe3ngBvgY=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 5F906C5D; Mon, 09 Nov 2026 01:23:57 +0800
X-QQ-mid: xmsmtpt1794158654tv0fkv2p8
Message-ID: <tencent_1B452721C0915FAACAC07AE0A2074838DD07@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+d+65ZsN8mR33XPMsjFoZb9oHtnpDkVB2/N0aqtRtOdovTpQmKv
	 2gnx6VoSoxhx6tzWleMxJ8m0jbZLQjA9whNUKWA3rW/oGAw4mOZJfFOFImAtenke3HiYTeBBvqFH
	 qJeKjUFR2XgwhV4+2BkwU/aQRzN+e5AQPOfY6bX/Zd0vBO12QH3QRWPr9Nzpc6Ksb4KZ+SglOzeW
	 b0bfJOG13kGa8rkGX0oWLsTS065gxOajGoqqOPsPrAFmOnpV7MlHAVRAFF3ZOaCLGdEJxxaPJNph
	 729y5wTMXsfGo/W/4dohKStFVZbCHxuztk6FFigdgN0rWl/WeFEJvuIp+4paWkrxWeU1GQmG3i4h
	 pzXxDQ8Lw/TDdsmRbOgXGTkhVVycTDhggTncWo28tdnvYTn+Nb9rBL09KZ7Kyr9eViw22sgL7b4R
	 Ntm+BDH23UA3B1N1U5yebvbzwztJSoL9WPB/QFhUlMMc19kvdSKSQ9FJFv2omAVAYwNQ0MtbX9MZ
	 yDIX7MZqBNjhx8xQAq/ep/lXBlQB+CpbNm59u11Rxyt9ClbZBSJ7gGlmG5iV8VMSGmWMq7EqwME4
	 UBCcTq3zuDAUFLbdUfhhW3MW1YY8MjL/UbEWVOhkwiRMPn+x2+nozsbuyZVkzHQ1e5KXJ0E+DnZw
	 w8MDaLuCZT20XoZDdn9ogtyXUXpC8j5ICIMwXJxBsveoGwwheNK115LyQA70qDXk5bStW+cZQQd9
	 FTCmNOrzK9ESeJHYtIUHo774oteOK/Sj8azsPWiJnL3MtRk6DXuaaLyxUrkORmoaK+2pbKkkFE7l
	 5mp23iBs0logfazsQ1wflKVMsNHMOYJCpXPc8biskGE73HtnxEc8MBGGyoEbA12zqThiy/DGVVw+
	 8WHYen+I67imIjY0N45yRdDiU/7RZB6/NzYjJeMzhryf0dADmco4sNqMKOBDUznMnNJR8w+5WdHK
	 wnAj0jypRyQOdBaUAI0YvG6wX3ppi5k7wvrCGnH0NTTr2DVUnpQbRRmeJN0P9hwb88cNkvGOykQT
	 eV/oxCKKTQcBp+DKgirFGbaPD0Gdro3FqvVwWKvjvhKEreKpn+6FrANpjmhXU9mpzug8qCXg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Jiawen Liu <1298662399@qq.com>
To: Andrew Lunn <andrew@lunn.ch>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] net: renesas: rswitch-main: fix runtime PM cleanup
In-Reply-To: <a402f04d-a919-4bde-b15e-b02c06ae1ebd@lunn.ch>
References: <tencent_2EBD0396FF7A54CAD61F16E942D2E8FA3A0A@qq.com> <a402f04d-a919-4bde-b15e-b02c06ae1ebd@lunn.ch>
Date: Sun, 08 Nov 2026 21:22:12 +0400
X-OQ-MSGID: <179415853266.5.1967874893812731174@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Andrew, Geert,

Thanks for the review. The description should explain the notifier
registration failure path and the resources that need to be unwound.

I'll recheck that path against the current tree. If the fix is still needed,
I'll move rswitch_deinit() in a separate preparatory patch, rather than adding
a forward declaration, and then make the cleanup change.

Thanks,
Jiawen

