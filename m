Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6633DB33D
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328474; cv=none; b=qfE4Yrfff1ngGGAyAqJjF3Gq3VfR+V7+W2zpT4SA6fS8DFmuWfNo6kecbxtQR+XJz4VPGJFZA/PaNe8VnnBJCAyAKbYhR/AaEo8Uo/+ROjXgmNpOUOCAYg8SDpyy6+mHE6HLk8DCFXktNABP5O0QNqLt0WEVAQHV/kc4QB+I35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328474; c=relaxed/simple;
	bh=abePKlk/l+PQxwA3CJSaoCaYhyicLdg38ytv/z4NBZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXn6AT+SQRo13pZoaU7eTH/lcALDUy85FEa90m8j6R17YaLTcGiiZAtcY59fJKsRMs9hQ1/wyXetCCmQYOcmjtOCKQTZGZt+clfE2KE+f8ZsKAoztuIUZeX2oCgQk7958UO3UEUZBdv4C6C8bgycgPw1diQTO2m55oxqAhDROlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOzJWgHV; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOzJWgHV"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso2522054a91.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328470; x=1780933270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fQ3OorwpsViEnsC4IDFs6b8rZ59dVya4v8+I9evXcY=;
        b=gOzJWgHVjBgrVjb4ay04K86DZtPpQLLexvKa1Wb776/91r8FRC9n7ZiCFaMKydj18k
         TaD6GA2OgoRTjjnBhVGw+uODbxp/01ziVIGuzrGhbAXbz5/JCvDhDfBIgubghackrcOG
         bYk8bOdY78Ox/lAbvG9PdVZgNAGgchKBHkSr5zcUcZ+KiU4nI8rW6d8nnjqj6HRy4GGD
         oYIsZQIkaRl1w0u6HZspSdKLUONKw2gMPkJ/keOAq1q585Lu9uNrhqEoai0vmp6nmbgv
         sF53TYASXBfOwWwXBip7du/T52NR/3eihp5FqD4z9Q/d8O347VTMdOZSsOuGUFdMZ5Pq
         shQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328470; x=1780933270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fQ3OorwpsViEnsC4IDFs6b8rZ59dVya4v8+I9evXcY=;
        b=J5W/pbCyViJ/VzxdZKpjIbUXA3tlsgJTAYZu77carJzgMsFuwjGZa0k1p+FIExfcMh
         MBAyBQ2k6re7M9WfOjTG2TCUiqn1iXIByAAgZ+PMMHNy6inpcggA9xNPaBuxlIo2KRf/
         luMbKk2+GwwyJOlQN7geI86h00cHZNXpCV9jaRLrKBC9wa9SEtSVXuhZ8rCn72QHXAee
         ATCLtFb4ygtR66FvIYfZpwXyriPhlslu863grBt01vrDjhuNYKdNcczNRYnSD7QKSFMo
         L24M/99G0juPPdARe+VTleoNanr1w/ea8Jsqhoqrz4hpBL/msBbr1d+Pv6yqgBwKJnnN
         B3VA==
X-Forwarded-Encrypted: i=1; AFNElJ+TmJyDhqdw7Oid9rDiaTV8exEcMdnSZ7hBGvcvnUmVKLkgjN6I1+aEBEBEqICc2sQ+d27uQoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmkduNZdq0X6RdwQgDJArNAdqAOlAWH2pxUV6mKeMZM9gr7tDG
	9A+1eCWZjhUJ0h68ySRDUfsHtguuW7f5iju5l5asaN0iKjPJWVIcVNlT
X-Gm-Gg: Acq92OHpA27XZe2oSka2yOGct5GfuqHINX2s9t1Q+d+9zgWTupGahmayKa40s9rQef6
	1DBlToywTdWe+cpFdsOVlns0MxfSq4nvHurAy4oecWJjCm3dq/+ncIpvwnZZI9xdSnCnK/bTrT+
	ckwppxw812XUkzOCvguZaDooBtM3PVYHS0rzgiUvhB2VOfB13SasO2VU60FVY8GA8KLHB9maLit
	TrLkV72SB+2t68Rv2FhnE8+YHMe5auohIddVr13gikGAJGPS6LZaBEQx7nVipDj8/vfy742V5MH
	m4zpV7rRw77kd//QCTmrijx4DfRflPTyalzFOf/lryUxZDyA338iWWVR0EB6kn0H+JV9eFvLWW9
	lsRRsa9EakTZgv+ZelOXh618eyBUaz22kr2wDKBetmXhNEIKyQuaDI38E8mg31DaSrSAdbIbyTu
	9t4obx0Xos5BwhVf34RSEx0rBzpXNRnWlX6cIbbQ==
X-Received: by 2002:a05:6a20:d709:b0:398:9662:10ff with SMTP id adf61e73a8af0-3b427e7bcc0mr12800053637.4.1780328470461;
        Mon, 01 Jun 2026 08:41:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85770b9e2esm10457245a12.0.2026.06.01.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:41:09 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:41:08 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: change bpf_skops_hdr_opt_len() signature
Message-ID: <ah2oCeCbMbYZeJys@devvm7509.cco0.facebook.com>
References: <20260601093819.469626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601093819.469626-1-edumazet@google.com>

On 06/01, Eric Dumazet wrote:
> Some compilers do not inline bpf_skops_hdr_opt_len() from
> tcp_established_options(), forcing an expensive stack canary
> when CONFIG_STACKPROTECTOR_STRONG=y.
> 
> Change bpf_skops_hdr_opt_len() to return @remaining by value
> to remove this stack canary from TCP fast path.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/1 up/down: 10/-59 (-49)
> Function                                     old     new   delta
> bpf_skops_hdr_opt_len                        297     307     +10
> tcp_established_options                      574     515     -59
> Total: Before=31456795, After=31456746, chg -0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
