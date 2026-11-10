Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346452;
	b=4gVrEDaGp/nzETSEZCrzcHik28cJ1Y0Q3XOocq4mqzKfMEeaIwhQezuFCIBPejT11Px/
	 FNBgbinWqhnRjZf7xNc5VjaIRMWN5dNK+Fe7I4gOxSOFbCWMbsSpqld3oAL/h38MDx5dJ
	 2GDWKk0D1Izxbdjjflvo4CJL1iUepkKQi642VTyNSCno7Y9sa6TNzIqk0yYNT9b4Qhq2/
	 oQMHQ9BhsrBXqgrsqxkb42HI/aQFRxI3kNKyyi8rZNNfuZcC7iFHZO3uG1QjbwPMwK+Bb
	 mP37Eld51w3GxYe5FD7qvDgcQ1SRW6wEj1QxuyxBupHt5JNbvjBAelIjNHnJPMgeh+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CVShPwIWAV5qwwsj+Z2XqB1Q8HnkHs+NiQo31OhVS38=;
	b=AjlGO1KH007PI7ZDDjI3XsU5pR1yTj18+AiAcD1eOy4uoyDwS/PvlIln1DPH/FdtOJx5
	 BHwMu71KatZn09Le1So/A05JidWNoFiAB62rAPYx0n0NxRDxMe7n/W3ldB2Z1FkXm2lAy
	 0nZ0WXRP5QeX/6sonknf+IApyugPRotyiKsX4UV623+ek+XSz1aAPhBxj6NbgkqXNAhE+
	 9v6hNqSRwdAshYyD09f/DSkNzM5qs9vpF3wxSfYUQbU2REsCTcsgB6/qyfKzgfEGQHmF/
	 TFUz+lpR3i5fYVI7My603KyfyceMhNTAANqWyuMjiEV4tr9RzZN8BCL1O3iHQfhUX6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDR7776I;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47864606A335
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47864606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDR7776I
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so1834701eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346451; x=1794951251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CVShPwIWAV5qwwsj+Z2XqB1Q8HnkHs+NiQo31OhVS38=;
        b=uDR7776IP3uEKAslpCIeXdaKbnLRp8gh5yPnFSCW47oe7XXmmOzxKN9QREJ3Ji7Jbb
         VFagbxL1FTRS90OlUraftAkjD6pDdnL0Qci6W+nNvujWUvGlzlmjkFIGkE4eGreOf5KW
         F3YxKxH0Pwk9Iq5acfhSUMul/aMhoz9P4q7rc0naT13WR+4TaHpfFrIAVGpkVsHT/xzS
         yi0vBbXJRkNoYejBV4rMDFowAbi7L61+hInZaKAD6tlx9Q5ONqkj5esdp3/YZOAARYgc
         ZYKwA+jdFNwdZyhm4O+LlRsrm8g8vrjTw5r0ZMCrUw4w6+OWhL5ewB5BnJH/bf5UEySG
         OERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346451; x=1794951251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CVShPwIWAV5qwwsj+Z2XqB1Q8HnkHs+NiQo31OhVS38=;
        b=ElSJS4m/v706o2mEYTZjLUuyUpsRfz6UIdkA+eIKY9r1wHjWZdpphfkWulG+zfkX8g
         oIzBuJvqVzyMOsQK3DyskGkJaD21qdRd4F9t4B712b48D8Zy3pDiZ2v46nohqWwPQkLr
         JSPzBi16R+sL22Hq/BViGKR7tyXDVZBnUWwPcTRSIw6FhPe4iag77xE67aqmriyVt4lN
         jl9OwXLXrY+U6bOfe8dWJxIqOfEWFgyq3tgcxJtQC2d24oHXuGqIulbhtyXq0RA0SUFN
         77HhwTzXwFdT8ZgKVOA9dM9wqjCjeMPs1Z/zH0UzNVVN75/Dltyu88DOwGJIuxEz9TbX
         Wzdg==
X-Gm-Message-State: APuU4Z9fqQ9bhJS5B95hcj7nibA9N1JOw5o7qV4vag8Wwm0sBxBmfmO6
	/fVseLxgDSab5vaL/ouhlNNgaTAh1kH6TuspyNcx4sQZqW5oFiuRyYi2
X-Gm-Gg: AYBFou3peWvWQ3xXSg2RQaGlnZBRvWn+ql+KSfy75secQ3yxTtqIs4NSUMyNR/9O2A3
	/FvwqVdMZ9Px+e/W2pPEFZZEgQw3y4vGZSgmns0oyoXMXHZv4phDVdubWTQPAwY3XQhbmhaUOX3
	WjJsv/y12UuQCYpHGCAibqJ3D2OrGezJyvq6bPQCCIM1V08j+EXSzrxB4HSRiLMO60Bjc0U3bmC
	mTUCF5bjQFn8zQTKEkgwwYpyL4mmpSzAQ8IX9riRv3rhsCr6baPAB8ZH8VmDT5zQSYZBuao0e/y
	+9J06R+PbBgER0kzLT9w0kY3wt+WlwDQkUGprjZclxlOyrt/VjQWhtJUCUqyCklaYIacZ1QA+Dr
	GeJFoD23O1kZh4AxBlRVoPEnDChjF5Y7BSm3TvDSXM8m3iEb8g9cJnRTrSZAq7zH8kNILSda8wR
	EAU/AJILKT4N3wkVI7rCQ403bZDKXMbiRcz+bgM4CKkveXKyRCFRkOOOImIs4klULMIccahQZG6
	oFXClfH1FNRqEmSP13UOjITG0H9JkJAheUVJqtCqdApK57Iktx1RRDntzoJxb5MtN1B6tvHNtk4
	UD8hOOO/A3fYC5hAa+GHcklW8fhXMh975p8quGWB0nd8xLnbCHGLNZZ8U1Xfdz9XHNRZ03S5OII
	ebKs=
X-Received: by 2002:a05:701b:2905:b0:16c:4eef:a526 with SMTP id a92af1059eb24-1b3c02f3f0dmr147061c88.15.1794346450891;
        Tue, 10 Nov 2026 13:34:10 -0800 (PST)
Received: from localhost.localdomain ([116.88.205.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm11245716c88.7.2026.11.10.13.34.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 13:34:10 -0800 (PST)
From: Zhefu Peng <ilskdw@gmail.com>
To: nicolas.dichtel@6wind.com
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	mschiffer@universe-factory.net
Subject: Re: [PATCH net v2] vxlan: reset the remote's dst cache when snooping moves a MAC
Date: Wed, 11 Nov 2026 05:34:05 +0800
Message-ID: <20261110213405.70741-1-ilskdw@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <e8066ad7-7a0c-4789-8859-371aa04fd652@6wind.com>
References: <20261110153020.9635-1-ilskdw@gmail.com> <e8066ad7-7a0c-4789-8859-371aa04fd652@6wind.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/11/2026 16:44, Nicolas Dichtel wrote:
> You should put your real name.

Thanks, I'll resend with my real name in From: and Signed-off-by:
as v3.

pw-bot: cr
