Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333127;
	b=tidi08b1daPg+Xq+HuDHAYHM8HK09cJkoFJ5DB2VhSQ3RMEhIMDqtEI8RETj0yvc7e13
	 ChtupigqcBHM/SGbfDjLv4sQYfKow9FZShG+xKXSCoBr7lKqH1KRUpnlJ30jXEqe46jAT
	 9cfms5ouK1KB+R3sv1jSZKLQ9pQ+mYGPTGLvtsMtxyUsF/fPTfU7ZV6yR9BR5viPsbwd7
	 9lWZvB8Gh4XntAT0ucJIFKY/CdhwXbKxRmoO3AkrVgYiFrACs7D4GI52GtBNaIj+3nd8h
	 IfOzy8Q6/kQwFRzweSVk0ojrMKV0U/nu0ViUh8EI6PbViQh2tIFYYOh3GulB2LKPjSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SfRySwYs9+7Dj7BUT7PfgHxeuU9IrkPDlfJOM1vwqbQ=;
	b=llGU+Jvlf2u5gaP6R0BIRcI9YEyfL56Kwauq9JRgoF7Q+NLXrSB5qGe7YPK161ibACDf
	 02A/xkJq0/yNsWndXEQLfN19vhxDEA9rEa1H/y/arBmnvsdxJXbg/sjnmYWWQ5NitobCD
	 QkC4s3GFekqlQUDZqb+ypebeBE2107Z7Av0TdE3vWnDfxq4FrsiH6+gHHxaS7vYPKPjYs
	 rTflx2QG7mNtJyeyh/h1B30ki4JHAzUyw0J65DoC22yW9g6lga5pfl1wVRm0bOSNxuMsw
	 suL5bWe1oMen7om5y6G3YMS71iM3EVnFzqBXp65eiPF5ZDVZ77piTlPFW8uFgyV1ZEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZ59t+Kj;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C32606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C32606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZ59t+Kj
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4af173320f9so1265273b6e.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333125; x=1794937925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfRySwYs9+7Dj7BUT7PfgHxeuU9IrkPDlfJOM1vwqbQ=;
        b=hZ59t+Kj8VSxWqouVXCbF3fsgG8JrnIyTRdknGdNPPQqkWJvm2KB4lOODP+COo6Nt+
         UCpii5qjWZEYImif04rCBW/rqLOWoQvOyqudCn/CcwE/6+f39HLboJSgiUdOklT+LyYF
         zFIHMu9PeR8grGjyW/EzBO5RplAOL8k4Si0WB8gK8uHZSKK72vOJvhYjWzl2m0ZsdO24
         yRmdPw7RzxygLq0PdENlGwhkDkfsAUQYmzibil8cjZnxHml9nC+T9ur1KyvKv/9nmfBh
         062eeaI+SsntdwwMQLBumwAnaz572le8I4q8a7jJnDsuzMR29C2vdrVYMmwGX089jEZl
         754g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333125; x=1794937925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SfRySwYs9+7Dj7BUT7PfgHxeuU9IrkPDlfJOM1vwqbQ=;
        b=RIEqSnNYh2SB6PYI0MmOwF3YfGtg3wU73AlRTyHQ+3e9DkjbZNGuFF39dgYX4Ln6NG
         km46hqX3oUj5tjHfVTEFPitTaeID8PorkZHV+ArF2rATt9g0n7vjsix2jzxam220vmUa
         bDEZAx8hd7NnpVvVMOvfoxwZOyfcWHdNOM7WG5MWrpr0gDnndoAaMTU4aRXkG/S1pmOa
         K4vN/6t0YLAYo8ZV0slgVrsz68vBSAOGqOuRGmTxk9PuR3can4A894rOyFbB68Lwt0hu
         nSCr68aWdUIkgKYkBpEzzzKWuGIEZFy8kxfTWVDG8ZjXxc2+nkEN2ic4CGYi9qbIn1ol
         nvXw==
X-Gm-Message-State: APuU4Z8ysKs/aX+18S84dwttjlkzpd3KxxHPjd29dkD595LPU84rcozL
	Aqy9CpVLjcWFvC1uximDqKoZ8HVZtKX1DsX327xoVQ9G1G6nXD1H9CkD8Nfw/vlQ
X-Gm-Gg: AYBFou3YQoucGcihGxDxhi+QdbL792B2gFAyEakH/W4bq+KtneHWjpT2WqfHKBXubuN
	8pvknpauGDiQJUjUDZGEn8eA3cZejWszzwwMyKaQ2I6GCJajN2ePtL2VeqA57cUYWiyQg+2Eq82
	fGagdgWLvb58kKJnsJlSjd7l2ZVpyGzbZ5QolUtEMjU6aT8GVeaRyxJ0wu8KoYd/GkRRpd+F2sm
	TaZC7O/M4sjxHY3H8Yxl63wzbXQTxsUqoedMSSqHGblMp6mtLRiF5dWsbAWeu1/g6eSmIbGjHz6
	g2F+5An4+ra3BvkCTHBXk7dNZt5TOphxmZ4pMWUCHVhm4/0zhkIw+hjn+ANjatoUbJmV+ofCkpN
	BFjf50vIt5KkOs2Fh0k3Nb0+FdBek34k4qwDDgx21D8Zn58/rVOrB4mbedAmMpKJtLt2W2Gyyi1
	Iqh7UMgip0ahJKYpHqQ0GryaKl2Uchsq5Jv9C0pKeEPvY8LsgWuS2RCGTdWCvDgti81jh9PY7K5
	uU484rE0ztNg4VlTxnEGQtAnejbI42Mqwz0iF22xly591Hz/RfwLHuvGlwWnsNEBh2QnXsQ9G3n
	EaTdZOGSptq8zIXdI2pwgIAchw==
X-Received: by 2002:a05:6808:2222:b0:4b3:8d45:aa2b with SMTP id 5614622812f47-5683cbf2cdbmr3019790b6e.16.1794333125517;
        Tue, 10 Nov 2026 09:52:05 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905735edasm2689969b6e.7.2026.11.10.09.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:52:04 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org
Subject: Re: [PATCH net-next v6 1/2] netlink: specs: add ovs_flow del and set operations
Date: Tue, 10 Nov 2026 12:51:50 -0500
Message-ID: <20261110175150.978118-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179414156764.994134.5410552449080338660@kernel.org>
References: <179414156764.994134.5410552449080338660@kernel.org>
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

On 2026-11-08 12:39, Sashiko wrote:
> [Medium] The ufid doc promises that the flow is indexed by that value,
> which does not hold for a value the kernel rejects.

v7 rewrites that paragraph. A value longer than 16 octets is read as if
the attribute were absent, so a del that carries such a ufid and no key
flushes the data path, and a new request indexes the flow by its key
instead. A zero-length value never reaches the handler, because the core
enforces the minimum length of one even when strict validation is
skipped, and a dump that parses the same policy fails the same way. The
spec records that minimum now.

Measured on the current tree, so it is not from the code alone: a GET
with an empty ufid returns -ERANGE and the same GET with four octets
returns -ENOENT, which means the attribute does reach the kernel.

> [Medium] The get reply also carries the last-used time and the TCP
> flags, which the reply list omitted.

Added. ovs_flow_cmd_fill_stats() adds both for a get and for a dump, and
the reply list names them in the order the helper writes them.

pw-bot: cr
