Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81A3D3317
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044470; cv=pass; b=gnQ5l6uQ4SvFE/sESqeXvIAion7xDnNzFcnBzCpVspW5lhS3i+tt3IFu7u4yuO2YGYpaqBuyKgtnwdJabZujg/hsFRE/sJ1NunAAvtAEqgpAdZ+0sClqVpMMa7nRAWEka2nyMcT8V6psDwJexoAkD5Yrrd9eXmxHxvsXGqedyQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044470; c=relaxed/simple;
	bh=iUV55gIu4aYclKwZ2UeoAZWtDqJYux+N/370D2hWb3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3OjnASAGKMI0/eyXWfxWyQMd9/R4iEfKOPSltMtKSGA/A4byyS4CnR/TywsHZkwlLfHEIqsN0qI9vQQyaj823z8cPXS4LRyWP4JUoEm6zVnXpYyopUwKGaZi8wPFIjfarNAPnR9X5d9N58gAZbCi13f6sMHAXZ66VZcB3JKIjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhUFZE6Z; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhUFZE6Z"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacef7d299so24755ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 12:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786044469; cv=none;
        d=google.com; s=arc-20260327;
        b=Xhv4YRJJchEILf7aecCnrLcVmslqGPq3fEEdfSuPK45p0lx3NUIH3B5HxXke4gubHH
         C61yN/yBjfJ3DoLyelkcFmaTSxZSAI4XP90LHmy+ydgt2ruD4M3Gv2txM++X0NZ6O9dG
         +/tybIuF+h30OX2QN/zhN33wzvj37osJniBa/bvTHaC2u5W0vo+AlGQKJkjr7taNfcxw
         NDN9IEriMRGJesmhEayFq5GDmi72mK0NPfC+upWMYF0kjLBMiD0jkTj72q6NNlPGPqc9
         EVH1xlfeqfsT15Q9/ShJLlhaNk1H3u4WuruxKPAoDTaDjBklhvaCPqsY1ds9I4HBpJIj
         mNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RKDxq6e03wLEUEpXNUuVpy51JZ2keZfmV6/afBlsFiI=;
        fh=yTYzHmnr1B5+GGzLzQABnUXmsXy/GUneDJ7UnyoZNkI=;
        b=PzgMssPbLQxt/RPg5M4HgYqdDMjP1m1INnwwlulat1ab3a/Enbj5b4i6WmLjG5syIC
         37orvvuO/i+iF04SoBU1z0nTTBcus03DYUrmq6bxesp/vJeOlb9k8fX5DdtOzE1jKFWS
         pCGhPrYScS9GMjyYVIDFA5WH7yBvBb6upYkq+qOclUTOcLVp8RGyVb39tWgOd7gFouiv
         G0haPpPvefWqVEu0+xF0+lpMuYip4wmek8JRzy7+rmwMfR7pkwqzwwd6LyZX10+J1mN+
         mIvbnQlVI26xGtTVmJKj8BPmseRcHm6Y4IwIBTCE7hhvw+VFosSBrJofk0MZIzx6zeWL
         /6Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786044469; x=1786649269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RKDxq6e03wLEUEpXNUuVpy51JZ2keZfmV6/afBlsFiI=;
        b=EhUFZE6ZB9SrYy+Z+s7Lmm07wVa2+eKcktST2HvmDoVCCrTHriAoxUGVfTrmwBvOhP
         I1hFRYVTT2YzT+CeXaR40H5NdyoorWJJOa+sqodoH+6eD8Mb1R1mYmzeRCb41N4+GgJU
         opaW6aZPddAOOK87l6LweGMVZOIZtW5svRmnf4MasZHTaqTNv60hDV7I2h02x2Rha+LT
         6majc6CYEDn/M102F/ihLc3wrZzq+aH/Y1BKjrRii11zrHf00mrMqqYxmRkxUSiDjs+S
         Ua3l7fjquYS2t248VZbOI96dHLwvUCrzi0L7d96k0VyblHgXRQXE6OetdA8wpRudgxOa
         kbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786044469; x=1786649269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKDxq6e03wLEUEpXNUuVpy51JZ2keZfmV6/afBlsFiI=;
        b=V8RdJZctN67kq4jqvcoy9+TrOtJe8Kvm55ddsrFNXSw0m2dJFBm41TWVsS5DJFZoEA
         bUNeKN+6cKV4im36s8Tkte9TIDDZ3I7pMUnG5MDvXGbUXMl6ss3K9GmBCkQ3ApVYm0Rc
         RqJbNGAILTedD8klQd6LvmEQNS85f9Io+4sDXbHm79LAWBfp81RJO/FbvTkk0KfdayEc
         XtDhOIgSJxz/avrUcdcvFz5iJF/ydXboPAzrOJaGZlLW1QXfi15nkn2XdEGrI2Kscr9e
         vHhWd11ZvjgAqAhBk/w2CefYEvyBm+PQtsqpB0oNgCytUXG/culQn8KEiMcJhrMUCXm6
         Ersw==
X-Gm-Message-State: AOJu0YwMbQ6Ap81vqKYcKYqMFzOcwfhmJZvpx3X6pgvgK12tiw978sG3
	IcSng7F61Bm43L8oxoyd6mF1JLTBrAFwr5GHbAZyX6HcH69cOcogjWIzBkqcCOhV1n1uW2VN4Y7
	t4P+OYBj+dg/fVsxF41IQF5bakFpRbVrMXLDHvL+l
X-Gm-Gg: AR+sD13sRxlCPFEPHMnBP5gDwT/lPrUNFPr8Gj4y7u2J1/9MKuVkDY6yzkEVy4T3mN7
	O3s2S4mWZSe/8sYouwvzESyk0hU5fsXrSHl0t47rQ6ma5H0qjAqawYn7PKwLqNaLsyxXqYvv+f9
	xXSxb4MKj5mq6AC1JIPPMWMLgI5ImKfm5TchihHoqGPOPJbkmGbZtCBldDzKI+ryFbmR0L/DEgh
	V03gwlg9wiZZACIiv901twEIh7vvBSva7uNtKYfhTESRaqWUOqI+PS/Lxk1P29E5y6ciSDmAJGK
	mwJyR0FpD7VuRmx2NOygGa2LrUXPzVMuXoE+qo/Ft8z+KKjC2qcBhLGadNr/iEsq1+VVSo3rGwk
	=
X-Received: by 2002:a17:902:f2c1:b0:2d1:1d3d:97c3 with SMTP id
 d9443c01a7336-2d120537ac8mr1601595ad.13.1786044468248; Thu, 06 Aug 2026
 12:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803181852.491437-1-almasrymina@google.com>
 <20260803181852.491437-2-almasrymina@google.com> <20260806121602.711dfa34@kernel.org>
In-Reply-To: <20260806121602.711dfa34@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Aug 2026 12:27:34 -0700
X-Gm-Features: AUfX_mwqNjMDNPTTybK3pB8uuckkeznT_cqRY7Nyr9TJWPsHvswqs3jxPXVSagc
Message-ID: <CAHS8izOXwOe2jZmyniWChdU-dKwoFNiVRti66D77LxQS8AhoCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: drv-net: ncdevmem: gracefully
 retry bind()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  3 Aug 2026 18:18:26 +0000 Mina Almasry wrote:
> > During tests, ethnl_rings_set randomly bounces the link causing a
> > transient IPv6 Duplicate Address Detection "tentative" race, resulting
> > in spurious -EADDRNOTAVAIL aborts inside the ncdevmem server.
>
> The test env is supposed to disable DAD and addr flush on down.
> If DAD is enabled multiple ksft tests would fail.

Ack, let me check how to do this in my test env.

--=20
Thanks,
Mina
