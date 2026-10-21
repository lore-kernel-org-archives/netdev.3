Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792622344;
	b=LQ3dmfmm2IXgZaISXuIk06CnxUwU/XDKAavOERk54sQNfDIYKYsOM/ZF86S3T589DOG3
	 x51lSBLkGDa0JWXTEE8IjMQNmTN3WlyVp/aGp53ptnu6ul7d9Ql9YBSADs1cWuX4n+rN4
	 LOHHhB/2voS/sedo/ytYUIUz7NCfaZf8lvjfWOFqvB6jmWBmpClZTg3lWowBqnxxoh+YH
	 xtfE94Kfe3kbKLX08ZpB1WgbHRLQR7ZlsrSEekHD/fJDT/A7qgo4/Ee4EoMUzFEzSAUW4
	 hmPmIVdgWxwgI/SgPX/Vaj913+8Mraw5rpi6ymXOid9qomB45moM3ANIXJx86xNXKeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SmC5QDaZtY/tUHrpKqljZ15wNyGf+4dy53b3mfaEpts=;
	b=wtWr3ckoPxzyJ4tmdEKvSEkBrPgPmvpvtNTY/ZTq2WJz2ywZgHPta/3y3FBQygBWo0nA
	 dKqsAYr+U/h5jIRFDP+KBb6wqlIW6iHUl7LfC/FuiNQG2b8aRw9e4qP1eDNVxbRRC24LC
	 uwGTZdjXuRphI23kO4BJk2n8tov4fxALfSAi76oamsK1F1XRhjztGUfnCkCBSTNhB3tyc
	 Q8y6BNeGpxqDq9Nt/JflX4WQBoqrJX4C393Xvca/pccJGMea9s6BWb6lxhLntHJ5XN/IJ
	 N7psz/peNqqCL/WvfFVsYcbdqFtSg7X3F101FxptDg7njdyceSEIJo4S8jYuhZiAYqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=ipZhChH6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC81606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAC81606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=ipZhChH6
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8ab43af5e97so3935987b3.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792622338; cv=none;
        d=google.com; s=arc-20260327;
        b=dowhtDCOHpbEmPUlaw3E478wLqXABAIay1S0jApjNoUfw9EZzbSFowWKKNMILRJAce
         t1Y16qHUwKQgG1w8Nlxo2UwtnLcOCGo/y517TFJPdygh+CqhTFAGWLaE+aH1cHLW+N6H
         ZxZgoHthRbIbiBncMeUaxkm0cGHHQVKcAFhpcKNc4vApLC30MgKp/RpLiymARh09k/C9
         MAwDuFjJbDy7TFN5hPX5/+vdgNH0jKlurVbzhEgpGiAj0YP4YecV0m5bib0N9E7x2UA1
         3/U7dQAOhGAS+asxOLqyaGH2+0V1G9jWKrbE/v791ZPWCH47h2iN+7byHUolPzPbmXQt
         XDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SmC5QDaZtY/tUHrpKqljZ15wNyGf+4dy53b3mfaEpts=;
        fh=RU0XXoqruSROVK+TiqI/0/ipyW3eBx1f9kxmR+KTt3o=;
        b=apSpS31o0k4WnwiAAW2RElUchqc4WCr4HDhEWBA9JYzf8t3LmI2nhOcq6Vojo8z4cA
         Sogu1gsj3vUA/pWTCKJB8+LccCqn/aD2i4+m/pvlF+MsH7gvM7Mk0NrC9CA9s35y87J4
         zxPvuA3yZcTyUer7YRyt/c8h6qTXUZmSzrLdC19BFEqVSuxNChmpDyDeaCjATB3rovqK
         +FYGp7AZvNY3VQAbEMasAD1ckPUZ0BzC6vtJ9MG4i/6F/kmmzfX6A5AiIGdjLkHgME1e
         fRPGLKMxRmUwRApoJef595WJ4Ye17tid7kWMK2gSM5JC2X2/3BcnZZEsDUj7gx7YNzbk
         UeZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792622338; x=1793227138; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmC5QDaZtY/tUHrpKqljZ15wNyGf+4dy53b3mfaEpts=;
        b=ipZhChH63S3JydgLIQpA2i/1Q+0ZwZU9Kk8gbIBur/B7FjOkuH++WKK5WXDnZJhdhB
         dZH7Kn9WD7hxV6WFIlwjPzhw2vlptHIn0nwyVrTf+EzK4a79NRbmc7yTPUPZPdxQkufV
         mryx3cKnr2UnkfFCrfDm5Hgkp6Dz1oBrmUTnuVw5yfzopboKEr8cxdBn4o3YIs+UNOwV
         Hd0V9MjwMZ2j3fEmTwzQG/a0B6qudXcNmnnrHEuTNBXMdI5XkR5Ytl/nmPbhNi24j31Z
         v9mbeHEfwePAzfphL32krwpVyk2P9vwxCKTUWhsJGnD0llOAXPz92ok3uJ3ShxfYlofZ
         WocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622338; x=1793227138;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SmC5QDaZtY/tUHrpKqljZ15wNyGf+4dy53b3mfaEpts=;
        b=Gpdlm3gxy/p9BFEqt+FQrJ0adMn3wiLQboxjruXlHUKfdMPSZmpSE3FkPRic/XMJMb
         p54vxCH5Q70qRwc3ppJ+EnVQF1EYGIROBaSBVucjyFjUTpq8qsszA2OrJvM3In4LKGtX
         WpfcZ/aoqQnxuzt2Om9TmC1YKlOMD87a8HgepROKcK4jmFLH4zWCtH1BlmOrsNRDsfMp
         H2zNjPh3uXYKxY0VhrfkocK7DEvfrHahY0w9HGNdfhyuvFVshlrf9pt1+w7/vxyLCzLs
         KnBmj5C9ZaDZrntEyAVICl0AQftY1CFb6kIZLxtQ5anEJDxpSLMqBmWj50lBQfVO3V7U
         CwjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwMEqbfhsEoh9tOp/7Wi6I0RWClZwdYZO+jvDPN4WPEyDy6Q/eien8t5WiqTB1wiT9FhJMEcc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvnF13NmDljXOV+NJPLyY8xWdiLgmvt8k27dvHB5ulRYlyjMYH
	pUJJXoBZB8JO+gi5Ow2noad6aEUiBuYUxgHLLdDd2MSx99Ic9BQmBK9RpgP79Wwzd578I9f6VLX
	+CqQOoF3WzncGQAPNHeZZ7NWAP1YlUmUg8R5CrbAn
X-Gm-Gg: AYBFou0mi5OmW4OYSZzpfHDrwQxdFZXzGdmOeb/cTGcSznx4o8G+/Z91nulq7hNUWf6
	DEwEytjYmk6TuvzOGXYrbsV7/w59rG4Mqs0HLL9KShCynXipxdBJ7BKFAcgPozXhLrpkmhPlm6f
	d4G5vKfZ5tfUx7RZi56TqaYD3oAkMwh9Pk7w0xKOAjFa2fiUXwOFOMHIhOGzKb0AJ0zzl9msta5
	AkS88ByI2eyyPH70RKrg0qhuC+At/3LCIPHQ6+OmY2abZBzb+6ArOCo8NPVaZ7ofFSVG4FE2Hz2
	NB+o0GQEJ5gPEUuUbqtz36tEKA5444t8J2CUuFeheAw2orEbxWKNKAnkT2uFJhihSMcgAToiOiG
	ddONIoF+BjT1HYQ8NlUvYeboBwlb3QKujq1map12NLWNMqBH3pUVBui14uMihzNWpEpzgewypZI
	Xmm2Q0YgnTnFk9Js+wU+F6YqDo9YQsM6CWe2hlrbCUSu7xk6659wjZiReCmJUTG1mhf4llYR6lz
	wE8GHlG7Tj4A318Rfun21wQrL4N9je4LxYwKE8Oid9Eglw+zaqWBkG+OWoPtD7o+FtCuOj2oTx4
	4folMMSjL6SPqzkGP7mOfz3YXZaKmJMa72u0eIff6G7y4+LK0Ca2Cw2bmyyNDnQ7mhxtw9c=
X-Received: by 2002:a05:690c:dd6:b0:89c:41f9:b8bd with SMTP id
 00721157ae682-8b145717273mr4834527b3.20.1792622337820; Wed, 21 Oct 2026
 15:38:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261004171628.3544978-1-julius@bairaktaris.de>
 <20261004171628.3544978-2-julius@bairaktaris.de> <atQii0cO-HJb5TQ7@chamomile>
In-Reply-To: <atQii0cO-HJb5TQ7@chamomile>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Wed, 21 Oct 2026 22:38:21 +0000
X-Gm-Features: AclHuK9eNtJ1Y6ncuQtLuxl6DPZP2RAM-Lbg7K0P7AME9akQS7QgqY9EuzG32NA
Message-ID: <CAC1t37L_0ayne1Hj5Eg6xkfgWvu3uVU-sw7rdjgs7J4Ov=v1EQ@mail.gmail.com>
Subject: Re: [PATCH nf-next v2 1/4] netfilter: conntrack: pick up a TCP flow
 whose SYN was never answered
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de, 
	coreteam@netfilter.org, netdev@vger.kernel.org, geldot@protonmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The series was written to offload LAN to LAN with the default send_redirects=1.
With two subnets on one link this doesnt work currently.

Would something like what act_ct does for UDP be acceptable? The ruleset
opts a connection out of TCP tracking, and the flowtable offloads it
in the one direction it sees.

Or is this all too "hacky" and should be dropped?

Julius
