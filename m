Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329364;
	b=h9SX+MPxEwFWtXObL8NtAkFRW1bRipKpFB2b1vCq8N8AZ2BGSGh9irO+PVEj0Q1qh/G0
	 EpDpsKeZGE2tlkt8+d34m7ERL7suWxi7+yeeJ32xgq23ChOkKc7+yD24W9sSa7FgNGNVr
	 mEshfhWl/6sA+8L8Djft2N4doDkO80XCsi/WEAIggqR7lWKEGVu3LngORHUe9/n+ydfn5
	 yej7lhFBsGhc4WI64Rbc2JLmCwG7HTGLHuF9whnFdEfIsAWLtUfRcufYWmXO6FTlk9ZjI
	 o9Q4qI5/afyb4mncG71uTe8ZqtL/OMB3lDqyPlW8Xi7gLtcfU4tQwg+Ot8RptKMqzfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=nPtrbd2Pn3rK1sw5Bc8c1fg7SY1qBfAR8Azz15uZZXI=;
	b=IswXo9y9vtdrEbPaoYkJ9dvhskVpcRKCaj+cWRZ/tqIG97hS6ICO+ZqKgRCJCVrdc19w
	 Dzk9wlads8fOty1stugBt5DbCGm1gqp+ufmCTDtbt3OrE5VkoQ7RwoE0fHe6i5VDADHts
	 EUyfENQT9EwuKNwGYNM4R72PYhG7eLJkHIk5M/CmZoqOyrohZPqb/Xevkvpbj6QZBeol3
	 PajjfJ4ET0Xqgrsy6ruvi5CcDT9bJD1C6mwBbbnE5KGEz3P7Zg8EtXDHbFVfjlf88Ot5s
	 LHwhEsbVmh/t5lAEo5S4AJo8tcPMAdGB8BTmvCPrcDmruL6Ia8uUFt897H6j0oxF9eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POE2dKJi;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79DD606A339
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D79DD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POE2dKJi
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b24f4b15c4so594043c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329363; x=1794934163; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nPtrbd2Pn3rK1sw5Bc8c1fg7SY1qBfAR8Azz15uZZXI=;
        b=POE2dKJio14LyaDVkR+BmbhlmJfL3c+ppSMEYXAn68Zh1qMJQkRRgYrFpfcjoPIdxe
         LKNTJZ+qLl5KycuQa/KBAa0V7qCYDceZ72rU4/d7aIOqMEqb76zw8F2kBmFjv/dkSrts
         8KeVMjltoTlxis9vnEKSzF/mz0U2xBpQzv/CUbpoABR8TmmaIhAtN95GBKAYj0bQ5y4K
         WTflcwHcbLFOlptFw+pVwlZcd51SidZ/s0KEYDXY1vnyaH6k3oFribB2jbDeLWBn3Dei
         8tpKh9Mhgze0pDpKuFNQ/iUQl12ffQjfbg9Z47WfuKSCBcxZHxrCfv+ORkavKx8ydT5n
         yrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329363; x=1794934163;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nPtrbd2Pn3rK1sw5Bc8c1fg7SY1qBfAR8Azz15uZZXI=;
        b=nmmEesxx0a0me/Grvqr4UyZjDdwGlN5F+fs1NOr4OLVYPNSTNOJ77wP02+eyB8a2Ul
         0D6JnRdu+J2At5AekPfVq0OWLeXL2UXQNVOSOOYjXELFqlFl+44OzN48Ar5+3ysdqjCV
         jtz/mpL8sHGM5Gog37XFnGBezCRL2ETQiLSYEkzZgHeuOrBoEjwuDMVTSoOaYF3Am7V1
         W16Na8T50P+6Yz9xseXbvRv5qTpAF3bLiWinkfde5zMYnH3KJZF/FU5I2exschg1AaSH
         TkDjuHNlc112j3bOHoWJpdZm2Njul1GqKA2IZ1Z081AGu4hh1n9WdyRqvZrpjC9uslVt
         ZaPA==
X-Forwarded-Encrypted: i=1; AL+hErEV+I1WkN6NvURffFy/yKPNfOdY0+oJHyDs49L8k0Qj8Db0GVIYRLzkeySgCydYCyiHTRzBn7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/BI+3mEAewmHWAZ0fQEMpWw+lrxkM/t9YpngADaRM9BQDUa7t
	JmPPTGXWc9iuEI05p4ggqBClrYfmmLvqsUEwtJ9dnvsNK2xhBssDYoHO
X-Gm-Gg: AYBFou3+aSpp4EZzFzkAqhQSuyBk6FZz86yGf4lLUsmKWD6bcVCV3Jqe81SbHbJezxZ
	57RG+o+SVaS5rpXBE+coaRcStSpBqnkQGoy0l5rKx33dBiH7eK26HLDmi35B1s/CyU2el0NeSm2
	okXEAzrB4xfBwr7YlvF93ghwYJE4brrpPP5Dim6dtZjWSaY7YBCfRdQZcK0G4/7iFlqm/xOCz46
	oHBeiXd/QeGIOAg0dMaSRytig0r+Hh615yuN9o+mDHJ5heCnZdSCyFxIl1jzMs3FZSnqfquwPbn
	kpDrQ+NwrpqpeWqF0reG4XMQxqdSsDsMTGKdWH8HZYCDNVfJx3ligISpTCSDw4FGbqOz/lXZqE8
	OfQq/S7Pp+DMKNjMlZoAaR1z8WX7XU5BOeOFLVpsS0PRYd1/6Qv+lJPP8o7cyE+7Gl4N9CjY3P7
	Pn4+rKKXKUVb6cXHbEDYeOX2k/Fa7Kd97ZnR2IcJrS6qvuwULjS2iazCFuaBeDDvz04daVhZdTk
	qTxKiyINoZn3vbjA+bVNrRTfpsizYV3Vn3W3oE0m5j5watnXGATf6zkX22i/nXO67xbl+bqnXgE
	qsHSh0DCOBp+Dx0Gexp7NIIOkDvDO0QmeTXzCg/VWStMFRmnQSZqqAKYeAplScL1K3U=
X-Received: by 2002:a05:7022:1586:b0:14e:d0ba:75af with SMTP id a92af1059eb24-1b3bee94f73mr67874c88.6.1794329362760;
        Tue, 10 Nov 2026 08:49:22 -0800 (PST)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5ba8426sm7208003c88.23.2026.11.10.08.49.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:49:22 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH net-next v3 3/4] selftests/net: packetdrill: add TCP black
 hole detection test
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <CADVnQykoJWJL+vZ9GC=RqZuiSEypNtmTONBzV7XRQ1jsXy0X_A@mail.gmail.com>
Date: Wed, 11 Nov 2026 00:49:06 +0800
Cc: davem@davemloft.net,
 edumazet@kernel.org,
 pabeni@redhat.com,
 shuah@kernel.org,
 kuniyu@google.com,
 horms@kernel.org,
 kuba@kernel.org,
 netdev@vger.kernel.org,
 panweiping3@gmail.com,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <18B3E417-AC3D-4A70-88BD-4ADA9003ACAF@gmail.com>
References: <20261110-mtu-probing-series-v3-0-dedfab25d641@gmail.com>
 <20261110-mtu-probing-series-v3-3-dedfab25d641@gmail.com>
 <CADVnQykoJWJL+vZ9GC=RqZuiSEypNtmTONBzV7XRQ1jsXy0X_A@mail.gmail.com>
To: Neal Cardwell <ncardwell@google.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

> So I'd suggest renaming this case to be something like
> tcp_mtu_probing_blackhole_no_tlp_retries1_is_1.pkt.
>
> Then I'd suggest creating a test like this, but with only the =
following setting:
>
> `./defaults.sh
> sysctl -q net.ipv4.tcp_mtu_probing=3D1`

Thanks, Neal. That makes sense.

I renamed this case and added a test that only sets tcp_mtu_probing=3D1
on top of defaults.sh. With the default settings, the TLP and the first
three RTO retransmissions keep the full size. The fourth RTO falls back
to tcp_base_mss, about 4.8 seconds after the original transmission.

The new test passes in all three IP modes on x86_64 KVM. v4 has both
tests.

Thanks,
Yongjian=
