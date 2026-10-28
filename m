Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155121;
	b=4yDVSPuEjaiZqUQ/LGF/NhZpRStknYmnozjbPk7E7+XG0gSJCQ7FSJMeUCv8OUmjJp9l
	 C26MRJRjFeDyMv4JVvLf+DBHsvS7sRhHKU/5zXT3NVse+NMjPrfJdO8L0d0IPb38MIORw
	 a2zanXd5ZJSOjivM6m5QCqI3nK2yZtN1AgV7JFZeptK+ocQQuX89bkxakfJAFsslPvixM
	 phEgZwUiYrwjcFdBidoEN1rcaEyZXPzZbS3kkzAcb5d5zJUzssQdOfqFboihfSCnQLtvb
	 ROCdr19H3T1PVoIQW3LLbNyICPpU4StP1dH9MSfcGLvsf4DVdlqYEJO1UXs480x3vJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sz4u3HpKUz23LFhmma/JLWrak4UGChsbULg05R22p2A=;
	b=0ENADbjJrKZTQG5fnTGqXUA7e81tJhpxitVvN8LYPBuYU16u/iMBERpVJLCMKnKKo0UW
	 pqT43A+zauTunBHWruiLeE4WFIw6i0gL/v874SYSMBfeu5EQkguXb+gqowF59Q3zD4KXx
	 v1NKx72e9tBd+RJeZFjfPZEg0bnmz4ZoVVlNack5rViYyXmQjGub4UHBjcaSJqdrskS8c
	 bWXEPFyZvdxFbQdaWbrqwlP2InzMmbYL6ghjztNRzsbP8VJ5lWJSFxKvFo7InnTrFhKHq
	 5b9gWkwlsezQ3L8sH87si9KCH5Su8mKVwVMJnwI8bUuXl7yk67iQvWuTJpGW7qm1IYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQE83O7l;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BC8606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0BC8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQE83O7l
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so152905137.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155120; x=1793759920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sz4u3HpKUz23LFhmma/JLWrak4UGChsbULg05R22p2A=;
        b=mQE83O7lN8QiKB4YFOlMv4fGZKFIXikVyTQ1nRMcjsRrDZj0iZPt2NIjzaiBVW3f9i
         MM6wCtffv91D9M+fjhK4rUrcdn2u7DlYtW2oHEyzXSsgwMvJvEjnXv3o2uSfS3J7wAWi
         VvtpTzHDP+Fq6fMs8CB8lHmr7SPlB8ayjN+Pyyi5To5Fh8egEez/YGgWyjUxzpDBF6m1
         MPvvc7M8XSb9JodH36OFNHuM2TtPUp+Zw2Jw8BbS5rJxg62ASGRBXf+G4PzwtC8CBteJ
         gCEmHByKpWiiBHo3ftcelFcoVY0kC6T9x89IsrulJi/yu1drIA9u2cdG/OUOtZuO43YD
         8msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155120; x=1793759920;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sz4u3HpKUz23LFhmma/JLWrak4UGChsbULg05R22p2A=;
        b=fufXRbVT+lPIXPWoV2OSXKQOfm/Mn8HNPXTL64ZYqA27mtRfDSj08HlDq0vBDnkoaQ
         fvm5nLwt7/5U344doxC8BVL1m65kUrbwQRkIyHTKlXeZYptMme0FjTXmpA6lBhRjeoWu
         jqulP9pjdMn4jIT6wMXs7vdJgj5Tb82ZUe/wqaw4FBDpREy2dMpSpNCKk+nYixrCVG/Z
         cDOW6Axe55qAxcgHMO+T6VmSYpzBx6V0bJmJC1CWcRuPn8PLAu5/aSoniB4NLbR391KS
         70lWWfuz02HBkip6n+haMCtBfQ820dd2TPdVxI9Sqb0jOhAmAA+mrMHHSL9Ip+wo0ggi
         2rGw==
X-Forwarded-Encrypted: i=1; AKwUvByj2qetEl1RpqW+605/zz2wDyBKWwm81OwimmCzErDYSKONRp/dlX+bGPvBvt/SNdh3GihB2zk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTNzrvA3lO8m+kThiukTBK2Ha/uU491S62fIfBf1cID+cuLkju
	A5HgyuRq5iwzkHWdVJqOxZPPwTjmYgbOCheSjKc4o+QYsCI1vbX8IMuX
X-Gm-Gg: AYBFou0XoBWI2wls4IBWrvSMYtMUEsrZRVEvnNIVcEMexXKjo/MAigXgpI+6V0IDeK+
	DVovYFyck1FCdOVn7Lfz+5qY+nHxBd/oQhUSKavcFs4zt/kYUnUxjCjMwQLhzbUkbeWgHc99/UH
	oUz+ryrXP59lHNLU2IH9+M9mgrxuOPVJtY/IYnE0QtdUje1niARC8Hpc0DE+H7R2IxkkeYQSZeO
	yEeGtINhv3gEkM5Nl6tt9RBqxX2VQSXpOfPX4s40QDFllUIg6BjY+tRuGVC7F0av97V8QeQiy1b
	yq1s7NKSla6l7isXExygeUH1xS23qzBZYYe2Kqxyt2wDH7M5Y810GAI8tUP8YNY7ZBtP1G79B9G
	W9KC+TC7HJNMfW1nj3ezADN2wY+TxVg08mjq4XM4huYJJ31hvMY6v/8bjdB0ccZ3hFq9kOZsZuW
	7bDTMzMtXpO9RSQtPuRUQ9zVPP8XXlbGuYlblRuaxH6q9i/Pqu1XPAuAwfpkS7wPRKx9NWUvWY/
	HB/4pzSuYdxIpdKTmHLtsxrErnEojJNfOtuStV97b9xgHq9R+KoHECptJ13sXHLCu8HEBriNbNF
	vMcjJ2q5yIVmgsnV7lVHJtV66Shq6k3FFp32xht8YFi0dxxdzH0TbW8u7jjsEjHhEihu8X23ae4
	V7Hd+dDjVOtTkstl6ANZxxsBc/6PeZ83Y3nF3obyemc7TI9UZ0mkSeFWDTd5sQ1gew1iB
X-Received: by 2002:a05:6102:1499:b0:7b2:508e:3d57 with SMTP id ada2fe7eead31-7d03a289d03mr511256137.4.1793155119764;
        Tue, 27 Oct 2026 19:38:39 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259eb01asm4585892241.8.2026.10.27.19.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:38:38 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:38:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jamie Nguyen <jamien@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: kerneljasonxing@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.21cdd31ffbfbd@gmail.com>
In-Reply-To: <20261027162945.2122306-1-jamien@nvidia.com>
References: <20261027162945.2122306-1-jamien@nvidia.com>
Subject: Re: [PATCH net] selftests: net: txtimestamp: fix out-of-bounds read
 in raw UDP checksum
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jamie Nguyen wrote:
> With -r (SOCK_RAW, IPPROTO_UDP) the test writes only the UDP header and
> payload, and the kernel adds the IP header. get_udp_csum() still expects
> the IP source and destination addresses to directly precede the UDP
> header, and reads 2 * alen bytes before the start of the buffer: 8 bytes
> for IPv4, 32 bytes for IPv6.
> 
> ASan reports a heap-buffer-overflow for both -4 -r and -6 -r. Without
> ASan the read usually goes unnoticed, but it faults when the buffer is
> the first chunk in the heap. That happens on Ubuntu 26.04, where the
> kselftest runner wraps the test in uutils stdbuf, and txtimestamp.sh
> fails with SIGSEGV on every run.
> 
> Even without a crash, -r packets were sent with a checksum computed
> over unrelated heap memory, so their UDP checksum was invalid.
> 
> Build the pseudo-header from the destination address and checksum only
> the UDP header and payload. -R and -P already write daddr as both the
> source and destination address, so their checksums are unchanged. With
> -r the kernel selects the source address, which equals daddr for the
> loopback addresses used by txtimestamp.sh.
> 
> Fixes: b52354aa068e ("selftests: expand txtimestamp with ipv6 dgram + raw and pf_packet")
> Signed-off-by: Jamie Nguyen <jamien@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
