Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659500;
	b=JetZic54e6GUKLLmv6HdmigQ+FgYCYRwECdh9pC67VWunECtxJd6/Z3riRRlM/rTW+Ra
	 BI8pwtlbOFxUmTDOaIS/MWzGeR5QyDgxV1NOOCFm1Fil7cM5aureQ5KR2w5Lb6Gtw4ASx
	 oUuIy4NHJfv03X9eZHnAjvsyIYXh4aeztyA0tVob2rBtbQ21m63Z2nXm6bS7zdGh3ogVy
	 z6nhJ2bL6IbioOM1j47sBJaKktK9faNBwoX/JghJX5EUCrfyR4PnLGx87y9OrC7tuICLx
	 yneib707W7CzNGHdnA5gCoW3s0p3m22QNr+qQ5epiGmAgTYaZ1bpfzUS8vNIomA36LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=3QmP7DYfeKMX6W+XMxlm7nFN+GTZmZT7AU7by44PL8A=;
	b=KTZ1yBS6e/nHIXodapseXhIWnBJp9eNwp+XoGZlikEP3WoOvDne300o50vXIo9f5DRLx
	 rhWWpVGSz1niiRiqOyHajlvWa1eZMzUykwGskH3ouDhiQStgfXyiJ0SA1ku5tzQeqwKsh
	 U9bV3IyWHLjIzN+p3vDZ2r9gn9ehkxf9dIxmKI+Bs8Ku2X5vLrVvP9fPEqhSst5XjK6Fu
	 GX3jJphS0f9pmOX6utuBCaREQK9zLnefwREzUpBrm11bQIwcYlRgtX/uVrK3T3CIAuJ6V
	 G7xW2E/SgHqae218Fi3NBHzKBV5+lKPBhzu0mi/e+FkjJYCgL77PKacVSvslvxdcjbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWAypKS6;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D84F606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 22:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D84F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWAypKS6
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-89f639ba307so1258295b3a.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659499; x=1794264299; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QmP7DYfeKMX6W+XMxlm7nFN+GTZmZT7AU7by44PL8A=;
        b=EWAypKS64YSe7zbnDh2J2Xks8FwquEFEljlLq3SM457UPvkpQJLTIgVbbNAC5o1XOE
         uYqQG4XUmfrn/dSMbrMMQWG9VHqCk9ZUBKsLAsT6/7IegjdogQn9+08isn8wdHKPwmr3
         GCLs61bvRp6JZ4LBsRoXg09pRaWFGxG5tLh4CGGQ2BdTKZcwuPKrxsak0QtikRuQjuc3
         tGCxDW17YfGsPj/E6D/nZtivGr5y8Ln8PlnH+GnHAVIJa8B2Cvb5U9lZBmYPn14O2l0r
         z12TqYW8cN/sHS0dgE/TaLdvHT6/sYu0ke0AnkKalTBGKLe9r+trF7HqdbXcyZKAuIbM
         yF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659499; x=1794264299;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QmP7DYfeKMX6W+XMxlm7nFN+GTZmZT7AU7by44PL8A=;
        b=iXEUZPMZKn1IGC/w0NDL1oR4RLohH1zEoxSHxKzlJY0jdgtH/BtuMNrG+cSLnUlO3c
         S+YuJm9ERasbAC+Xs/IfgQl70SC5oUCO1AZULesgqQArctif6GLmTD+3111k0A93XXzy
         BxLCdSsxrpnJKP+dObFkKAE1lr967Os2B140/c2STen3alwhyfbbJyGOCueGfxrA1kTO
         9MI/YR7UgUeJ+Po56nhXeoikW0DmjQsaRTTsGsqTTYsnDBCy6GDOxyPpLtz5eBh6i3ie
         RlpNSgmYPHfYijpxZXtys6CoG+dw/UeLYZH5GamHu5XIIhkz7bE90iyW7znM+goLFFNH
         oSlA==
X-Forwarded-Encrypted: i=1; AKwUvBzOjPbM6Q4+Iv93V/tQvWf2AruxKEMV6R/X/kS/9y079zhMwiNw6SoNooN1KFWNNq4u5cClR60=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCfv7zxTJTbgOjgZcHtmw7pDr0P4va0xGM/7E7Ih0CM0CvhU6b
	B9hjGwIky0g7vjbW6+CShJp+2DwxfTNRaSpze37tQ/8N9OPF+XVUOcys
X-Gm-Gg: AYBFou3u/QpbWggkDjQ072bkwENt+86FvQb1HjBROdHauILtqdedInswFB2rrZHhZxU
	U8qcDTW4GirsUZNTfY0tjCaXfAmbnvu2B7h4U5luuSF7uGE/3tkQdSYDIfO4aDVsBLZWli0Luzk
	ggfbVRNaIU7gOTtp8YVq7kZ5dMJ97O7fNr8eO9i0tYyi3ZEXrk1omqr6HIIvtNii+kwAU/XBjfF
	WOWO5qxAFcPcAKEYJRd0Ab44buRmkbendUeuHG+tbdaGWcGLuNbDEzEcwb926KH1w5tR9pLE9l1
	jcRIQjRqVpvJYMGARernSWiBh0ytCxsfVmwSdVQFNHyLB28KFja6Yrz5MK4t/nNqATFwUG1v8dd
	2eoKEeqzBpg0KudxuelTRlW7htd4x4cXrf2gJjy9kKREMHg77mZkyRPpOa/vKLR6mPwmeaPRp5X
	kpzhIjhP15TDPi4UAvXcWHzn0j2L6P7F/ZVZzPMVOtGlR5bDL2IRE29GN2SZgflFTL/kiFDYiIh
	HD0Pzby87XxyLqcSp+OajdGPV3pkp6s7jIY8XHliSkcZIDEOr4Mh1J7/kdivSLYhGSyoyZzkykd
	vru1qM4FQWbE+HDsP17xKzOJwaTSl6/ZS/hIB7f9Y7tLBu7cdCqbRFqJgdN11mMLyJINlemV++8
	xbnt3pWQxCcLxN0x2PwVwaVAoVP6vhVLINA==
X-Received: by 2002:a05:6a21:4e03:b0:3de:79fe:13f with SMTP id adf61e73a8af0-3e928d4d2bdmr9749200637.38.1793659499362;
        Mon, 02 Nov 2026 14:44:59 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb364cb821sm358389a12.29.2026.11.02.14.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:44:59 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:44:58 +0000
Message-Id: <DML3865PENEX.2KBDIHWGWBJ7N@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <jakub@cloudflare.com>, <jiayuan.chen@linux.dev>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <willemb@google.com>, <matttbe@kernel.org>, <mason@kernel.org>,
 <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "John Fastabend" <john.fastabend@gmail.com>, <mptcp@lists.linux.dev>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
In-Reply-To: <tnw1v9.qyjuvdc9kq45@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-4-alexei.starovoitov@gmail.com> <tnw1v9.qyjuvdc9kq45@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 10:51 AM John Fastabend <john.fastabend@gmail.com> wrote:
>>+			/* A part of it may have gone out */
>>+			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
>>+			/* Another sender can use up the rest during the push */
>
> Interesting. We've never hit this with http parsers. We do use this to
> skip payloads some times.

That one needs two senders on one socket.
With one sender per socket you can't hit it.
A non-blocking send() fills sndbuf in the middle of the push.
N bytes go out and tcp_bpf_push() returns -EAGAIN.
Today apply_bytes still includes these N bytes.
Then the prog doesn't see the first N bytes after the payload.
There is no error and no splat, so it's easy to miss.
