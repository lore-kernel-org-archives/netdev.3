Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296A284662
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663812; cv=none; b=r0yVmkBFKqtD9iCwpjqABBB9TkDfH0ORHsdI/n9CFILb/CwdmlwisEtaINMtmfo3Bg+4M6i/mke+AVld9b32tsNCgEa9I19ADyHB9UwaOmaG4Y24KPYrcSCf0z+GKExBuMJhhctXOw2voAAfx2pgINLVOlavXV57Evr609WChNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663812; c=relaxed/simple;
	bh=iX3Pr0EgR6+UtdUqIYFIqXNiohQ4bk5hzfaX0kY7hh0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JbYOiWuECAi03CV7AC8fw4QTf4eOZtqR8RxNhwN9t7G9qKBbvmamFmrlsLKH9qxkhRLp6XNCbhgVNoDB1fZvPc+F8idLmMKbHaAw/F7IyvOEZntvbxC9vq+hPLvT4z/XM6e6zjI2diij1/PH/okrrd6Hw9W2mJ11rizOVNNrhJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCniZECi; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCniZECi"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6682259cb3dso7236744d50.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784663810; x=1785268610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pa2uEZNROgBjdFkg/E+qGWTHncm4GHnmK0ZASuDc9jk=;
        b=TCniZECiLjxnuAdJODiAl4jxAnukzxtWrkbp5we4L+JIJk9UKS2ytR6pPmX9kwxxC5
         nGRumMg0HT+6wK4prkDPjt85qb/iwGHEsor3qwAARo6Ug7u0TxiEQ3U3b3QsIG6bs8pQ
         hN+TDQL8vQNnTNyuySTC/26V5r68LVRgWu6I+Wyy7hSnID/p4oUOJur/VBlUeLB6bZX2
         UB7WQvW4b9q4o0Sgx38rUqJqWjx7W+INVh1Qr5nvkblpgO4inhR8gb42qoq/UptuVLvt
         +q3XEk2Q3/aS4QGORe7xTqUJ3r5xw6K4HyBnukOnwQTrK0n3uXTeCGHRCecBlbobRjU3
         rGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784663810; x=1785268610;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pa2uEZNROgBjdFkg/E+qGWTHncm4GHnmK0ZASuDc9jk=;
        b=hdaJ3e3T1ccvxR/iWyl31CadkImiqEItM68nbyMNGRoyL96KMEpjZ1pMZXAF/USUx+
         0NrdLweelCN7XCKPrqwOL+C40yiVS+FColh56zUCwm1X+XmQTXhNmAFhlvL+dPWCY8f5
         MGsVAjJbMfSH3wVkfdVHYHdW9T55xKzRiL2omYBMj6LggXxX5alEQzFjT4hpzp+lxAHE
         6NAoIzVAonzTrPq4AN+DDcph85/VgFkLruLScjtpw8ZiBBMo9h7mAWJ+JqJ8TUY54dLY
         qq1nCNoS65pKoOuKLfeXG96ds2UirXRsrEhYzZ/fu7P+F50hKO/6LMIG6eHZhM+mRap9
         3Z+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrDaU43Xc+9cOh3PVgLpriOOuWPL4z+u3d2bRX0NVq/xuKNntv9yv5UytJc9Jku37M68heU4e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RrVynL04AuEYosIrXmI947O0kmkyBkSnvGdyP3Zl7S4p2RP9
	2YUWjH+Q79OqEE9w1V/SSQ9Fq8+MQ+qO/ZypSAbVGa8Ox5pg2bLmBg8fFdYNiBDC
X-Gm-Gg: AR+sD13O4lVm0EyDiLWu5vRvHgn/OocYcj5+glMmCOIfaxQ1JhamXfreHqYsO/Qdvmb
	QDIiNVUqUiE3JpCyApgjWmSXYs1e1jYSgG8LvluLlz8GXgI11chIhr6Uz8P+G6TcNpTRiVH/Ue3
	jMwrG+r0vywOnB4Iv8+jpEraUvbbvkUICElgaZ/FaP0IHVRhorAQhAuZYgMj0wm6xfXN4xZk7s1
	bktFyNi8MOpvUdVIC4+gh5f03B41B8lmRahE94/wINsUJycQVsarpFGBIcv1LeaVPIz16offdwm
	MCdc1bmXFXDQ25Q0BNjGxIDkhUY16vcdbDtkphYHxfKMvPKFHlRASQNZ2zYdAhH2LTGtLmUahiJ
	fKrP1fBI0XkcqO/675/n5+qRXVtS+SX78ZM6Gi3s+6aXaLdo+SpfMED+AAZ1QqXyTNE7oN+MMof
	HtdwI0+y8Onrj8FaJHZHxELm7/S2po5k2qSlUooO8TXhowJ+Xyva/dhgw=
X-Received: by 2002:a53:d711:0:b0:668:894e:4bf with SMTP id 956f58d0204a3-6688e5bdda2mr286944d50.13.1784663810036;
        Tue, 21 Jul 2026 12:56:50 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668907446easm115711d50.17.2026.07.21.12.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:56:49 -0700 (PDT)
Date: Tue, 21 Jul 2026 15:56:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 Joe Damato <joe@dama.to>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.54ad71e6c98a@gmail.com>
In-Reply-To: <20260720122714.759175-4-joe@dama.to>
References: <20260720122714.759175-1-joe@dama.to>
 <20260720122714.759175-4-joe@dama.to>
Subject: Re: [PATCH net-next v3 3/3] selftests/net: Test PACKET_AUXDATA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Extend the packet socket selftest, adding a recvmsg path, to test
> PACKET_AUXDATA. Check basic attributes of tpacket_auxdata.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for sending this again, Joe.
