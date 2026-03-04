Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3733E7
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664463; cv=none; b=j5c6U/N2KBJ8JzIwPSGbT/yZnE8530ZRvLFcORHw8TzYCUkAopM13i3Aghage3FeN8AyG0JYKfQE3VWm5XeuZL9u+2b4a4MsBHuQrcdDSqFHykuffVRznuRStj8FxIZVeL9gi9wdXnRPw2AuZXHlQM/IhkpxJPTHzs4eQWrPg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664463; c=relaxed/simple;
	bh=RtRZ4mJB+nwPC7VInmYlSfqnFozHJxGBkcC8/+L0z04=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=D57nhI0EXIneg7wMi3uYIbYx7jdCQeUtxcARl+huEJ3v3hTQUbR8Ieyu6a3nEVaj4UPDY8XKih52Rfi3Kj9XCKCcsyXIEv8XXP14RM5Vd72PhF7A693byYyXMc9jojXeNJ3+MFPUg5ffatcAU5OAltxMryUOdBgcHjiYzhzu7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmvfrLt0; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmvfrLt0"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9a6d68e5so5581375d50.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 14:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772664461; x=1773269261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PLHSOewuwH1PngbXys7NFtiqO5ObC1B7LLLEYe4qtU=;
        b=ZmvfrLt0iwmENXsPTVFjVt7GG0/O5vmGfzSIBagab3cndpv+DmfbfOJ0mWP8z685lJ
         NLERUSV7qvgTgZoTS3i5SvPyWMw9P6qfefyFPW1bjTJPIi5idQoCxMpQfQKK/KWEUiB4
         o6S2SASnqYf8lp3x2CqG2f4p+sYLxg6AixlkqsP0Np2nfXT56nm0qJ9jKmM0znWb/pNV
         88vRYosYuXHTKwSTmaPmUhHBE0SzfURKqADFklqUwg22ty2hPsE/Cd7h8zvZTqR+J4Nf
         Iqd0ShE89h+Iu+RSCYsPGm5+RScIE4UNa79SNSb+3UD3i8Cvr/VWzSEGdz2LSF60lwE2
         6RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772664461; x=1773269261;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PLHSOewuwH1PngbXys7NFtiqO5ObC1B7LLLEYe4qtU=;
        b=S9t62YGCA+fF8yM1n/ENqaQG+kxATp4+Iks7tgT7dVbDYVg5ODiBhjjeseCLKV0CSV
         R+4luaCAaJRomkW8feq9GNrJnc+YJqykjt5+AWVXujl98o7umIt7DFGudrXaojf3jPKp
         fmLOzKCxyG7pILJ5mrMz0aRSETPQS8JPJdkZnAb8FY8hWlBWd+gG2905tGFc8aB20+17
         PBrW+qRpa2BlSvYZpNTXifdAO7IF3tpnEmcaX4JTHiXpyaY0KWV/gXHL6xdH0GyUXhzj
         hPp1zxjBApYx1v86qhPFgqZbivjklVxYvuWKF5cMyGfO7Qr4x1oalKwfteRjAy2buBvi
         InMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnpbJZMLLmGob0JjIQywLkqQxrwTQZItvLPwHJeQdd5WOgr2Y9RgzzVEZInlBj7OSGU+c3xzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIw4IrpnWGHnAed97Xw49KH1z4vGiEe74/mbjOkfgP4mNt477G
	GgvINIHPcuAMZCfvITkSoS4LUzgWktZoI9tlUMiFGwmV0PnyY7c0J3RY
X-Gm-Gg: ATEYQzz9uChbAJAnXxg2WfID5o2Gb2CQdzNFZkmk5gRzSrXbVnwZ4+917fdhE0CA55d
	kfZhHQsKxihyY6VsO1/bEWnnXFErmrFUCp1NvxF5nCzA4sfAuhE/p7c9AKeZExD0jiSfRcc1oa/
	cNOqmg4ld9gBcJP0M2RGfvfkumrazC1PdWjiqaGzJFtSMZEE7Eub2SrTz6dXFVX+WEKbvb8XLpv
	hW81+bCVc3VMs8Fdp0Q6KzBPPRq8An6Ffqgar8dXtaOdt8cERH8QumHmjSrffq3WikhMVYua/Se
	73Lx4Gu1T7zJScNii0wLSnuSTTVN8/kbg9CT0OdCl4nrw5BIUeuk9AoIKFy5VkO2DlRnv2JQA6A
	z8nXGXHEm7LlAZfER5T5zaanwcoHO75BjlEaeMdTAvfz1oouG2vundANOFXj1SzuX8Yx9Xz2MiA
	aI8Z7TkBDMp/tvBqhO4vT8Xrn2te6c2eyJ+QEGp8pHHZQPJEakL44LNghq8q4MLz7iFWZzIgw=
X-Received: by 2002:a05:690e:1c1c:b0:649:e4eb:cc6e with SMTP id 956f58d0204a3-64cf9b6324fmr2971183d50.34.1772664461412;
        Wed, 04 Mar 2026 14:47:41 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cec30a69esm2439891d50.2.2026.03.04.14.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 14:47:40 -0800 (PST)
Date: Wed, 04 Mar 2026 17:47:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1aabccf28abf0@gmail.com>
In-Reply-To: <20260304193034.1870586-10-kuniyu@google.com>
References: <20260304193034.1870586-1-kuniyu@google.com>
 <20260304193034.1870586-10-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 09/15] udp: Remove UDPLITE_SEND_CSCOV and
 UDPLITE_RECV_CSCOV.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> UDP-Lite supports variable-length checksum and has two socket
> options, UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV, to control
> the checksum coverage.
> 
> Let's remove the support.
> 
> setsockopt(UDPLITE_SEND_CSCOV / UDPLITE_RECV_CSCOV) was only
> available for UDP-Lite and returned -ENOPROTOOPT for UDP.
> 
> Now, the options are handled in ip_setsockopt() and
> ipv6_setsockopt(), which still return the same error.
> 
> getsockopt(UDPLITE_SEND_CSCOV / UDPLITE_RECV_CSCOV) was available
> for UDP and always returned 0, meaning full checksum, but now
> -ENOPROTOOPT is returned.
> 
> Given that getsockopt() is meaningless for UDP and even the options
> are not defined under include/uapi/, this should not be a problem.
> 
>   $ man 7 udplite
>   ...
>   BUGS
>        Where glibc support is missing, the following definitions
>        are needed:
> 
>            #define IPPROTO_UDPLITE     136
>            #define UDPLITE_SEND_CSCOV  10
>            #define UDPLITE_RECV_CSCOV  11
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

> diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> index edca3e430305..195041ffb7d8 100644
> --- a/include/uapi/linux/udp.h
> +++ b/include/uapi/linux/udp.h
> @@ -29,6 +29,7 @@ struct udphdr {
>  
>  /* UDP socket options */
>  #define UDP_CORK	1	/* Never send partially complete segments */
> +/* Don't use 10 and 11 */

Could use a bit more detail. Something like:

/* Deprecated, reserved for UDPLITE_SEND_CSCOV 10 */

>  #define UDP_ENCAP	100	/* Set the socket to accept encapsulated packets */
>  #define UDP_NO_CHECK6_TX 101	/* Disable sending checksum for UDP6X */
>  #define UDP_NO_CHECK6_RX 102	/* Disable accepting checksum for UDP6 */
