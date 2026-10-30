Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331285;
	b=yaeqJ/8PnG6kAK+dpqSVclpAdM1R1h//L+//CVewRcB7v7w7wtiICDoZpNBsThYo2IqM
	 0oLqBdjkvCFiGiC1nl3kxbCyfPsBIwdFWAqmNB9xIY1Cz4MUafhASaJa5nUDZVxa74S2R
	 Hv1/OO15MtY2zzqHPqQo3ZAqN9zrYO4c1MFLBDaGE1h1nBY05MOasbG/acgBmTqSXKDXD
	 E+uFt2zTzAC/kbIpwdNMRw/8VTlS2sxaPThOF4n21ocbzqUF6xhQibzjEYCWG7/EC1bJ0
	 Z9cAwLDNDSY6PiYuqFRBLde8HysfW0olo8AUiSijnS6kxEU1JFJhlWo5Oo02OPiUdLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331285;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UpMK1eS3G+4e5yAU/xnlikzuJMV8mVbAyBsPVRuDU5k=;
	b=BZQP4JXqt1bkcbjUMiNcTo900unpJ+XTh03FCnAGoAkdpCvqPZl2UnIqemgHV1aBRTyI
	 HIDND4kd89CqL0Af7SDy4gQBSwsjIdDyarwBrbuAQuVBBLqTwQArpmwMwkHtOUMgq9eV2
	 Fq9T/Ff2Kb6bo8eUUdJog2/V2tVnJiOfJdsBC9AnfbeCHs/cre0jLBCXSc9zrZZM5gQK/
	 sbtOMsRKong+LZYIWUZP6txYTCRPTe8JnUoawBTuDhFdSwq+MV1YrGQkfjjy3ZheGXlyy
	 RLIduDnHm1jXBPUEXEIwQNjCu7afytscy4QLNsaAuvx7jmTJZNePGgYe2tRkSZTxLww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=P1i6J4gz;
	arc=none smtp.remote-ip=203.205.221.209
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4B606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60E4B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=P1i6J4gz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793331281;
	bh=UpMK1eS3G+4e5yAU/xnlikzuJMV8mVbAyBsPVRuDU5k=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=P1i6J4gz3qkmlYbtnCGjoU2Xsg0J3BAIox5c+z+5opCawQm5sgpHntvKLYUMivuBD
	 cVmbdEeLdyA7XLDeIF4Ln+9i5FAAgMrfXXKkm7EtELQbxJwoculzOsuioOusw4b5iq
	 odjBahtSi8pHkWBqiriWg+PtxH48WFCIEOdvP0qQ=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:5da5:a99e:d3a2:d604])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 84D24025; Fri, 30 Oct 2026 11:33:13 +0800
X-QQ-mid: xmsmtpt1793331193t77gxfd8c
Message-ID: <tencent_9A3D612B75599BC18E420368621A5A296A05@qq.com>
X-QQ-XMAILINFO: M9B5ARjGA2Wm/d4swbdMrRO4E/+mnGGIzS61HubAg3usyhJeNhr7tExAcWb/KK
	 BvhPlFj91JD1DJAKn7OkWAmU6/is7CvM/8HOp0p6QRpOPQR269ruP1uBWDYUbd7ub3aYYcLRZyaV
	 Ayx8qeER3HZVOvFTE7hQXl72HfAziYzFNFl7lkStoyVPG4HyVyov0MZORIERMoXdzktQAsvvLSZX
	 g/DswG8URS5ftWntD7cftdKGCvwzNTHwyUjA4apXDDZ3R1S+ldSA9a6GmIoAtyKYlxRcfeB5w87x
	 OopArzIfhqWq/pRsw/swnSd+XzUxWtiDbYtXP+NZWS80dLcLbuvG7/PvLcV1U47jECNZkdbv0KvK
	 RYnf9mSYGuquwXEwwxRhw+Ei2VNCVkhA+1iIrJmn/NSnfRbRc28RUuoIf4oi/MKWiXrj2lBl8dVh
	 aOH7u2yyFqJxvv/LSsWK+Jh1lz9A5u9vutmrOQZBLHLlL3d4229NHZGvo0hpKzwI7ERrX3BlCYT+
	 p9ZStMBPSTOC2n9egd6vf+N/lEUtg69u43mzHX4XZmnRK1TCU6Hk/5VuQZaDLH8uyyoWMcxv/VaJ
	 nzYsEBj7CCmNrTopA40K6KPuhNOZFu+fTrGiRQgfvIOVsPn79f9SrZ2SLMzabC7pphq5taoGiABO
	 vQyJ1TswDURF8VwhY04/YQFEeDJTr84umulEOjTWK6dW5G0NJ/HItGJwNVSRcCpYJIYOHVZ8hhrH
	 Ic9IRdCHOw8hcRx5E0qx39RlEe9FBthDpMPvbKHbSX++9U4l8kwo9+P2BSt/RtF1qLsbCbKyckem
	 s3cYo2iD+xhsxXohPe2eOXKccuf7CkV2h8A6jeUEHAkqZc6SefBMY3oiDLZx+qgL5ti2vIV2KUNb
	 ddl5AXpH02OHJ4VCgEipE+J63An49K1sYOVa4UIw4Urt2pRc8BE2UBp6vEiisAB+U/HAR+taQyh3
	 lHCrODHfpqWO3Hh1Kf2NAGq9IpBCYFyBdJVIZT0jj9Bi5DYNUcgiWJoSfuu1oaNJNJIyBmDZ9XEi
	 kJP+uXs0UuMHVE9I03c+rCn4V51SR92o9/yKNQYXOxe0MV3g5O0K5Pg8ABhmA=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: dsa: mxl862xx: bound FDB dump walk with a read limit
Date: Fri, 30 Oct 2026 11:33:12 +0800
X-OQ-MSGID: <20261030033312.2607-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179327344028.3327.14084939226295973095@kernel.org>
References: <179327344028.3327.14084939226295973095@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Hi,

Adding the requested information:

How discovered: manual code inspection. We were auditing the
mxl862xx driver's handling of device-controlled API responses
(firmware as an untrusted party): both spots keep consuming or
trusting values that the firmware alone controls -- the MAC table
walk's only exit is the device-set "last" flag, and the returned
bridge id is never checked against the values the API documents
as reserved.

Triggered: no, theoretical. We have no MxL862xx hardware in hand,
so neither issue was exercised on a real device. The FDB dump loop
and the missing bridge_id checks were verified by code inspection
against the GSW API documentation (id 0 reserved, INVALID_HANDLE
documented but undefined -- 0xffff in the MaxLinear GSW API). No
symptoms to report.

Best,
Zhang Hewei

