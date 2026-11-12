Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490773;
	b=JpFmbvD168pa9RmYPY0IhbV2tefwGJIltYKze6qRNxF6wZJxMEksLSH/lPPU+f6n0tXe
	 6Mz/g1t7jwnin9I7Zy6MFN4aB+MTIHm0qZiIhdeQpIPMFcuJibLYjEMAAHrptgPbT3IuO
	 GI0wiVqaTooqnIpvGRSH4c9/idhhgwbRHqtOMnAQy6gTV7NBWIm3Xd1zmR48GkCpvPEfc
	 22QKhheAecuXi/UPViO+9fsrfnXXcALJd1U8NMj3lLdHruEp4GCLY/PtkzTCHcoD0dkX5
	 HXSijRUu68k5LLq9U0EqShDNKHfFmpdQwp3bHAOXUv3lh4Rxy+7GNR4dkeArxmSWrDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=hinaE5bXyUrpJk+LwEFRwoOnfVOGtmBFwj0E2lD/oHg=;
	b=HC2dX0TY6i86l9lFHHeR6qBpsGSnLOtCgrc3a04LCq7kNhBC1tF2WScJq3UAg8WwaZlm
	 iqCu4TG2F6kquvYJ9qTxJ6Pqvc5NAqZag4vRIvW2O9/7SUHcZzwwePTVHZGxa8G0I71kE
	 CoOIKpDepEEYLsqBEUWGENjJusdk34/HB/MUHeUtvENTKNe+eg4YCxsceXXTBYgcwcUVP
	 1tnQcgCs4juYAEb6rcIFztlf5hixYgBjrs1BBzRY52+r/+rEjxnnd7aJ/1bTvHcWCaQcz
	 E8yoeaT6Gka+WStMVfedl+Y7EJSdme7kaIdFfxIcInNbwutr0rOpfcYdMoFNY7AeHcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3+kfEWc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634D606A33A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7634D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3+kfEWc
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9eb579c0eso24718145ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:39:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490772; cv=none;
        d=google.com; s=arc-20260327;
        b=cl2x01QjfHBewOQu/cD8QJa8ebqdagCGtgfzUPHYxub6Eai5ZgPIpfmULJqqzwDbe1
         XseOB5dr5mazbRwt7ndUV4il3gP3wvmr53Ryyp0UrFpBHgeoMGL9bNr1WcqqCbkj2RHL
         7MFgKSLj/RHduXzhASJLebxUcyszWtHkvqQ9ZSklj7SZr7hZoiu6u27BGEdSijxQxN/9
         oAut/SSF+yyzy+ZlZ4JyvWm/XWUe7sBSmesO96tOZPi+OdpD9M+RcciXIxqOXAymthla
         w4lYVKn3sevg8aYnFIjL8VprY/2i8Hsn9BC4ljNUc4dsyoBPkRKo924D8qpwIxRAdpip
         Qr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hinaE5bXyUrpJk+LwEFRwoOnfVOGtmBFwj0E2lD/oHg=;
        fh=c4wNlO6OFGkcdAyuzobRzuyEm/hnm7PUlqh9PRb+ktA=;
        b=TD7QinO7+gHhgg8bh5568EDMqY96RAF5W8O+2jY+B04DRcHxAvE5VNqspryLyc1+48
         mDxsyZ6x9s4pIxhIamJ3nnCrUq3zKFrgIGGaSxcDY4OZtuY5DqMBjnzcMVhcp9JOZ7WE
         n5eXGeh9Irtl4sKtSsUHDAcM3RLUFDriY4cJ6uWoMohdT2GpjE4LcMjC7MXqdvy4Kvjj
         vArsMAZ/b6I7Ius9tlzttlkG5IMRG7SIlfh0mepyO8fKz1NACYWaR4zHP0eqyNG/ajRC
         JOQR0NsrBkisdgKo9+BU2iFzr6TTHxVlPw3OMUTH7jLGiJEQA7rWJGwjVgCl0pdN8Lpl
         7M/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794490772; x=1795095572; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hinaE5bXyUrpJk+LwEFRwoOnfVOGtmBFwj0E2lD/oHg=;
        b=o3+kfEWcRSjRpnaVC5BXZKuL2kXjIQHclfzpt6+dHbhdh4Q6hf9C3pmuQuds+9EpGv
         XaxNNfh0D9MQ4cnsO6NytlHcJUL0RE6lWpqnrCQ+3QkxlmdR++71qXfGEXWn+N6dngcb
         bwAgvGl+3PYQ0cvL7dvepdIKzygBCUJqWR5ktSitplquzfJdrhZBFAF6oeC0H+IQ3zMh
         yHqyDIYw1v3VnagA0ZNV3r0N31Qb97+qe9VWSSm+I+AWbGmhoty5fvU1SQSIDm7H+bkg
         /ahGhTUYTNYcBepjiuZOI6JrH+7kYfWkSsHHi+vRV67EhJrWZUT04BfCTjUKF4RYk6uo
         InnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490772; x=1795095572;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hinaE5bXyUrpJk+LwEFRwoOnfVOGtmBFwj0E2lD/oHg=;
        b=u5i8kLZ4QyHzb2iFduM+15E4J1VyFLgby0ObM89hlWvJ8zAeDm3tXOCMwmDerr1kfq
         xCfuxsrP8XRHqIMCNlwhFJL1zMBYHI4NyKh31eypLXCP0rQql1stGJY3KnFPgJv3XdRO
         Uot6dVONZJnrCyhNZX+N0Foz2zOByvv80C+Ya3AgROEUyMAWM+x8HcXekVtU79wJaq/c
         FhPqyBzOx24EBkhwPirkCWnnTwiXuLi19+qEizsEv2jWy7tvlnDC5EsL8gfsa4YecOIW
         NwBGM3UCfIolzmjLgIhccF8cMx+E/8a2be2LMeGAZdihsp149myKqgtRyOZoXMtVa/si
         LVXw==
X-Forwarded-Encrypted: i=1; AL+hErFFiDwQMDGNukK+hhaVmb3aeZFS4dYKxuAC69dy1w+rTOZ6IDfcCN7MJP5TPjECeAqNqL9Tb1I=@vger.kernel.org
X-Gm-Message-State: APuU4Z81TbmpP1T6JKIdFt7I73zwJLNpGewVepJy6Ha33+kHrUwzlTxg
	qrS2VfGIyj+2jRzKHXoxpzpdBPjs90xhbe130rS9ke3+jpxX6iAyyNAQTsXVULTPpDOnW/wOg+/
	wncBwy/EpOTmCAwm6E9scSN204rRsFg==
X-Gm-Gg: AYBFou315S46xET2Qrc6bwHZ9O7WVJAcGbCna9sd01uNCDNKNDEAK9U6SuUTv6il/rZ
	ArywInbbMJixv6mW/lhV2JmITbhz4Sx1GUAZATJdKB4bdFanu5yVfJR/8JPt77W41s+gOalLndd
	ker0ffunxYuuTxqQR2s/FPwhtIwp3Lbvl2PPVdmDbUDVU7okmdfcamMDdBcNHB1IaB1NAELB+/a
	OH+mJc3Kq35zYvOLiBE1CYsohZqu4Ho0VfCjCRYcLVuBO6F7kjiWWhDdQmMrOCmMBAAU3Zq+Tcl
	IdGCzRl0+Be12uI9QWKjtqfFcIBAUrp5xLV3N+VkHtQZoZ+oSNZ+gdNC+pLXnYsfNMg8fjALkfo
	2oQiH1ncGCEs/7vXeUrhxG8Jz6LsLJs77hrL7
X-Received: by 2002:a17:903:3c2b:b0:2e9:723a:cf30 with SMTP id
 d9443c01a7336-2edd747589amr58537755ad.2.1794490772460; Thu, 12 Nov 2026
 05:39:32 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
 <20261111-m52xq-dts-v2-2-063289405882@gmail.com> <20261112-sophisticated-peculiar-husky-c8ce51@quoll>
In-Reply-To: <20261112-sophisticated-peculiar-husky-c8ce51@quoll>
From: Asdlerto Korry <korryasdlerto@gmail.com>
Date: Thu, 12 Nov 2026 15:39:21 +0200
X-Gm-Features: AclHuK9wD85pxbo8x4o0sO-zJHkPTBWQEPCcLtvvrU2Ak_t5O0goATrr7wKH0Tw
Message-ID: <CAARotkfQxp0xE_XnixLeRLrcdrWx2PgC78BKv46e2NJiVnmmBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: net: nfc: samsung,s3fwrn5: Add pvdd-supply
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for the review.

Who will pick up patches 2/4 and 3/4 (the s3fwrn5 binding and driver change)?
Should I resend them as a separate series to netdev with the net-next prefix,
or will you take them with the tags as they are?

Patch 1/4 and 4/4 are the Qualcomm side (arm,qcom binding and the DTS), so I
assume they go through the Qualcomm tree separately. Please correct me if the
split should be different.

Best regards,
Asdlerto Korry
