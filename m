Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E413AFCF0
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479860; cv=none; b=EOIlCyqhiwjAHPXaK+EuzliRElEvkgMwEXaAxzv9h1oJRBQz9Vx/Ldg5UQdVSsq+VSHJmGSMRkJYLPVRidFp28oiL7/p6sb3NxYqhclstFud5v39s5PS/PqHjcM1hpMerd+zGH/FcAgvN1U8E1RzNaFAPfsBwekhQIoQo+k5ghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479860; c=relaxed/simple;
	bh=fa57BarLa3S4MwWGljw0T6+FFl5B5HOLbc1wS80I4Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aqql2NanRxHHLtG8nKWn3YBxc9Hj9+jbaU9mb/lnVjtGWcTAAeRwaPvXKeYQuuKPtxz5F51dw3chI/YbQSKacL2AndwjiPghPTd42EkrLm3d7PB71OK7t2tJmdnwHLjQiSUZZLVOUhNjoQFNbTe0kQZpZ/BdSReGtyCnAsTnZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS2HQWq6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS2HQWq6"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcb2ecebb4so3003599e87.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791479857; x=1792084657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0PLYiY/N8RhjOEjCS15BiR6ywDnnfcu/szHv5dRujk=;
        b=jS2HQWq6xE8lq1rtpRL4VZta8mxVld5O7SU3cw6IQqEEKyXS4RgMR+SJQ9Z/KrXfPm
         68GJx4TxlwlnDhdx8t4RjExja2OQTQ9o0R7l6ur9h9n2aCBu7zLirWVeYJyi+CrP3yFj
         qLc02xh65SGRlfjaRem5xG1vr8Y6sKfAkc1YLxajNKWZXEpUbsh4T7gYvoDMYovjVD+8
         gBTFALTe4ss7OVj++8BclcdTVNYjzrchsnD8LpEpyrK6k5JB78Nzxr2jny/4VJtmIRJ8
         28HE0tPuMoeUVZT2ibOOYR9/rhQ5u/kpsFJ3GykFdMF3GkA2KVUdOkdwBUyQ+vnFpDrJ
         3SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479857; x=1792084657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o0PLYiY/N8RhjOEjCS15BiR6ywDnnfcu/szHv5dRujk=;
        b=A7gSTmI/B2p/uk5xw9sZ1aSjaBpbm4UboFrxU2fiQhz+ccZFSdBwAhe6YUkeB6Pp1g
         OHalpmZBvdcvmQ3T6NHgCwGGtIv9vwxRQvtHZZbJuUDH/knTqwQuYnOa3Y3kF1oHyUQZ
         ezxaMYbDx2iIXsZwCmP8PCyGWbiKIVf9WLs0Ed2CLFHmXZed+q5gxDiAcnBKah0M+Qic
         Pa9JlC3aCeQfzkYM5jDBfUN65DNuxIGwDyN5SKwWvC5nEO6a/QblPr+54Y1WrAWdyS7M
         /Q/Luylz0VN4PIvrqHrRIi9mZQyaLpxWL0LZoRKnfpRONdIx78H5XR7Mu3yRgf85tBCz
         Gk4Q==
X-Forwarded-Encrypted: i=1; AKwUvByIx27uXxFYf4dTLD8ERn01dFwBXHgpYbBRGT4zctHL3K28j/8MM7L7rVmtFNB7dW1VFqHfTc8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM0LUmJ77gPirys+7xOo2jx3VhpCja+fh6lVNYiY7S0e2clA8H
	qwcddm3gLMJpGxDPw3hycUBFoPg+bIqMF4kLSLErN3USUchArZxiQbeT
X-Gm-Gg: AYBFou3zmG0DdVuyiDs7MCVyfggbpmb6Er9B+dxUvHz5w3/I4a1nRs9zs2f7KuGxB4N
	iGzQFAn4pXv8TkJhNHr6mXn7udoZXYmA8ue6rbQzGN/7luLgaUBUH04PRlMZv1loGP2n9Jzc+4e
	HkpS+jF34CWS9TouysQqwx6tFZujT0VJLM61ZKB8zuOOiFzFdpouQHDdByK69oiwzSkPC5Jxctf
	m7nnSkKzD/PiqpOO+YwyZmgFaK7X9qvupeegax4S6mxkFfcX0pj0cQAzwTz3Tp4L0/hjp/aFj2J
	AyZ3khkGJxIjvJ56LiJz4doY5wN0SPlXuQurhMg7kdsPrXt2is/ZtjHnjzRQL49L9XQ0ZytcB6p
	fEWd51iSfSqkq2meJCnqkhmyEV8TInO8nDYTMF4T1lEfN58r6upw1sCRRnfYJhiHWsVUfy8Qd5J
	5ToZ0DE6ke//lPp9Jz51VY3toOTN2P6Jt4sr+zFudu3RgxFhV4Kug0USje/qKkIkSyM63R1kYMe
	/Lk2dt6n6JWuiZUH1TaUf16IWvrTsk9BtsztSFZcn+Yx+dn7i8k
X-Received: by 2002:a05:6512:3a91:b0:5b8:bc5e:b57f with SMTP id 2adb3069b0e04-5bcd0712af5mr2293273e87.55.1791479856946;
        Thu, 08 Oct 2026 10:17:36 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd3015020sm1497605e87.11.2026.10.08.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:17:36 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org
Cc: Maxim Skokov <skokovmaksimevg@gmail.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	vadim.fedorenko@linux.dev,
	mason@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE
Date: Thu,  8 Oct 2026 20:17:24 +0300
Message-ID: <20261008171726.47795-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6ddac0398e54f73f0d424069145c6901d8d0ff3401fb160db0a9e3b281270c06@mail.kernel.org>
References: <6ddac0398e54f73f0d424069145c6901d8d0ff3401fb160db0a9e3b281270c06@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 07, 2026 at 06:45 PM +0000, bot+bpf-ci@kernel.org wrote:
>> +	/* A helper such as bpf_skb_change_tail() may have downgraded the skb
>> +	 * from CHECKSUM_COMPLETE. skb->csum is then unused by the stack and
>> +	 * there is nothing to validate.
>> +	 */
>
> This isn't a bug, but could the opening of this multi-line comment be put on
> its own line, with the text starting on the next line, as is preferred for
> BPF code?

Right, will put the opening /* on its own line in v2.
