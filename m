Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794602237;
	b=A3TiDb8omyrRB4DykPzpktB9ovANFWNksQqeKQj+m7mlB5Uh78cOnhxExpogvVVh+01R
	 z2eg42eUGM4WTkqwyirsPOHpNrwvbkvLAyvoiOdXY2CbrhU5LfVJouUphByHdrA+DB0hN
	 BptYJ6oXYWT6dhu7eIuPG7ZjvMXA/dSr+Yfkoz4g7Xo879Z6CPp8w+hz3WAQDNJioWKPZ
	 QTXluY3o1gKoqgkP6761St18HaST1Pc5XACUheoLlSVceNPiCrZXlwcTH3BcqtLw9T/UM
	 TElfahnTFOTRzWdwUwh542hBBU0dAT3xRTd4rxRAlP0wejqS+8kIHw5E56swDd7TrdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Q0zmMS95Y2iOsvCJTAiye2FTSJmpfdS8NTIq4CrS7fg=;
	b=W1xu3r9bW+6g7IhkYWs6uFEPH81Pe7Z5cgDXJTkrYYAljjgqFs+DW+3KY6bDCS4agM0I
	 XNnuMO1KDtltwnLl4MMyTmw58TusPSCWmbH2Gj/MEH/QpNFqDledS8EbavEC1Nl5PUgKE
	 7ph8WxQ+yFTCEI5EAuEc9PbOQWWe64WqbhiH3JNdtE39ujzX9rVpXvWwm5OC2eZg/xNL8
	 Ilq15itslGFuRBXCBEqZsF9cchsfpKsRPUFYAhWe/R+uGStSnhNOlFmNSVRRrDe+znIg6
	 RjYvLTNpNeNKG3JQ1mm0iOsNvNH7LIET4qr94vcGC+4K204tEbOKwF+sY+5VuAvRIYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ceb14J6a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E255606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E255606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ceb14J6a
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso342318666b.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794602236; cv=none;
        d=google.com; s=arc-20260327;
        b=rtwHFwgnwIQT9GHSrTf7vlaSM55YoEax1FaAz5o44bv/U8uw42vLwBMP745dKURdQ0
         AOHzKolkJF4dccdqEEQiVcumJS7W37Ah/kYaGNtlLyylZdcXE8GXyXeC8Zxvu3BVwdgq
         PdDm3u6fOmi+GkmZ3EGJ4dVnovXnIqXO57z+KFx+1dBDfeRUUvqFdVvZ5ydN1RwXvE+b
         9V7RvjuuQx4GecqIzQq/kO5CpJLfxbOw991UBl+XOm0llyf9P2TUhdLvNXh46It8owMz
         FQYw7nn3Dly2dl4g0eXkAKRMGyM48siYAsyMCa2b3yjpF09eMXrY3Oa3Wb1Tq8vjAWvc
         vIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q0zmMS95Y2iOsvCJTAiye2FTSJmpfdS8NTIq4CrS7fg=;
        fh=HX/c7wAa4UXjroDpfxXPhJBlHYwkEgnqljflredSg+s=;
        b=mdTgdfxWcysRqLm+FyaFPhjVZ48W3DUl5qdZeKjMHdyiX5jB3W3a/5melw1sYRleZp
         nJ9GG+FOciO8nzwgITtQ6J9SoEZ6Fl/XqQhzOqnoya5cs1kiEiWQWeknitrpWYZ99j/W
         l3eEWSzz9JFEJPxp1huT4LJ4ynNrFPfASdflvjz6dOqirEb0p/QPD+aUjptjqRr/rjmR
         nROk/UopAOAltCIOROagA2oRkOP7RC+conHz1oQ24PBB4eaHb0efNnrHfwreS1/y/HxD
         Er/yIjsQyB1prc4G4PiU2DMFAmZPMeQmjAoHONfiSf/ULyYcZpAz08YANKKfx93YKfCf
         WLZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794602236; x=1795207036; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0zmMS95Y2iOsvCJTAiye2FTSJmpfdS8NTIq4CrS7fg=;
        b=ceb14J6aCiub8PwS3mQUNXCY86BMGZZQN0L1eWWeFCdjdbQZHzYli0Me/XBqFJklt9
         XX+If23LQbF5WHPiMWO8ua7VpEW7IhWILPW1GW9spI/dcCYFiMts30JmZND/SnlNFFH4
         S5SPkdaqTj5jyb7Fs7Da96CnEC4YLZ699XdNoh6D30NY4HloKgLGZr78cCGDsb5k4Vko
         sHZCrPg6/C58dnhlVfWwFyJamWaNhSJmmel16hhiMUjUPh3cynRPiusEyPn+IflD1z8s
         wDArTtpsxB8ee5rurZ4JN7V5z3m7nGPitzpVn1fcQUF4J4Ko1jIgJqxn8ug812tScxKG
         M8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602236; x=1795207036;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q0zmMS95Y2iOsvCJTAiye2FTSJmpfdS8NTIq4CrS7fg=;
        b=d8iCM/cP4pY8XCJdbCV1Uj5HCBSv3nfenvPNvE4oTGUytnJ6BqG82hqNV9osy37nZS
         03IG5uQ7dmnZKstPs4Do6zwBmgjkga+CAqd+bbxuHgeI77o3OxsMhFhRTpqkPdVJL9QU
         EQtVNjB3lkM4DMeUYKE0KCqB82HFxVnkLuNlG+inMYlmrz0k4BvDyHSntl7tQbTJJblh
         bqI7LkvGijZx953wy94fy3oEElySrTt5HHnv9hfdne4+s84jCG4cqdHvs0LPgGOrEhGJ
         5c4yNxvoJaktewj9LqAqvDqpb8qf188ZMwSluLXee4oVUSqWOw0eHm0101CxCGyyk88q
         Edkw==
X-Gm-Message-State: APuU4Z/V4RyomhZ4WEQvb66EuBtYaqbvChnfq1CApSiD1mzTbf8EvbFE
	4wU+CPYMSYIIraGeTHKKEyJU/NG/AmGH98iTTpsb5AXGyxP7e4iolzbX6yb6B7ehuAep82En116
	QzPgM6PTJhJV15vHrmYllSajh8gz22Gts9VuOJdMcmn4QEb+kVVOfttqo
X-Gm-Gg: AYBFou1x6OujAps38hLXaHgEYIngF7DqGXLskwRO8qZVkkLNqaa1oZIJNIeoJik/ETN
	e1eH3Yy8N+6q8CLtJSr9WW55WtahMZXEGgsYM2E9UBKy630ORxR4n3oI4q/ucWfVjxEp7KejRT6
	tutbAJZZ/6vkNZk61U/u1d4kyqoRAouyfZDwbI+HKyJLbYuz+UqjSe/6ecxnr6M7rkVCk93ToNF
	cP5FD2ZKriO5nZYK7lnxZIoJsgNL0s9Obf3jzE4Xb8mQyW/29TZSO4tmc+222sb1Lnaf3rkkL9W
	wW+C8WTOgFju447a4QX5AEM4AwPp1W8IQxVn7jSZkLUyUIFQAZy6WvWF9GfFNiFrA6cgpStxrz3
	XX42J1X5sQKnXbBP2t7NLPjD1HVokExMi5+ragg==
X-Received: by 2002:a17:906:c14e:b0:c3f:c878:7c1d with SMTP id
 a640c23a62f3a-c5096307650mr316429966b.9.1794602235243; Fri, 13 Nov 2026
 12:37:15 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113195553.2220562-1-joshwash@google.com>
In-Reply-To: <20261113195553.2220562-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 13 Nov 2026 12:37:03 -0800
X-Gm-Features: AclHuK9ptA2Q7NDGZ-JiCdfTID2_a3zpW-s80Ltd9yW31n9tVs_J6wRqHrbt7_I
Message-ID: <CALuQH+XPebJ67K9ntdYoruXdLH0tSt7EFkesfd_=3ATNJiQBwQ@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix checksum state and gso_segs of HW-GRO packets
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch is missing my signoff. I will respin, adding the singoff
and removing the reviewed-by, after the 24 hour period.

-- Josh
