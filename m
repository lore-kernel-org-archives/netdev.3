Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342FE476045
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191859; cv=none; b=JLjvSXjziy8HilfO0eC1gwCJeU+5X62ImXck/NWGJW7nIKfwUrA720XCERyzDvsH5c73Lu0wvfO7WkEsO51T0VlFtLzNrEd1UOUFl42o5cmNucA5zmi4sqoE7mhSagUu3YzovUmNVui/Z9cYXc1wKf8TkZtJZ3JrTELqbL1Q/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191859; c=relaxed/simple;
	bh=64kS0CJL6qln+d9rasbeAa3ijPzVL9miUXFSBIaCDUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNDTLvH44Z516YIth2MUp5p/pxT+56RX06h5s5IDNzzCpAK2RcBe99l4FBE+nyic6IN6hek6DNVp1JRNcpoKTqvvYXhmOxea9IaV5nWvy8bA49XL1a/JLVq9nXyTo8RLWN8oqqcde2Or0l3+yq1a4ilNxFS9gbfMh867VQWB5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fT6bac8C; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fT6bac8C"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso41168895e9.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788191856; x=1788796656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1clWMxAyc5RxXZXlC5dQkJ/VfpdrrYMFRlmg9aI1GqI=;
        b=fT6bac8CVTeuIbtBuCIoVkBaPjeXR6bwXjoTJcwJuEYtOBW99GMaP/yTH6MRoEk6E6
         //+V2z0sk4sZYEHktIxX3VAWWCge5lNTZkQuRV5AUghE9z0FNgEMQlsYceWHJfgEPS2z
         9Jd1imGxcOdTxSSsVlP6HooXP12enTEKSz3WVw779SZ9FaRETBER0WlnjK45lhbVY2FK
         KB6m3CtpBKUkTGmF+8Bvk3y88qaah/rV4c/s1j3Juvl7WNuXrDnm2Ioptv1TR3X8/gvd
         NOPB0N2Th9BoxSMtNewZoX4VOups/jRNi1pC3XQEz81jrng88Ynpo5r2K4h3VZktOB+D
         gn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191856; x=1788796656;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1clWMxAyc5RxXZXlC5dQkJ/VfpdrrYMFRlmg9aI1GqI=;
        b=SxnWI5qtp18MeyR7EKueiB4H2+QeLEt4ZJ/iVPIa09BT/LnXNGD082tSy53tWfljMm
         Z8D1mhrESVhPHSOL+ZParNlBE6PzhPIIq1x94WDzsG9LWiG34Usj25Uf+D07UTK81HC+
         iVW8QlmS61qqEMeRxwqwFw4GKsBUK0ZGjH2T19hec1Bqy8WKqHe5TKSG9Z6bAdBVOsxa
         gFAX1cc20fhIBkD4NO1Hw3qW4Fb0WJTs23oi49ZxG6nPTLS/Xi31Z4JenZh+fUA8HeIu
         XeQS0EVysa9dFU2lJpNbxtiohnKbbM+/gId341fl2Q/KA6nfUSNAnOfZBh9WppUHtAIi
         ux/w==
X-Forwarded-Encrypted: i=1; AHgh+Ro1NtrXE4U+VCIZajbUk2MrYtn7EqILbNMJj9jrzpjZzLhx+LKLvT5K+RojSbe/4thBgB2nexg=@vger.kernel.org
X-Gm-Message-State: AFuF++n+mCVphZAi9DzVDZ+3CJrpc/tbQ0+QeQEdPioew/j95I62C/YX
	tme3+WYcyMjUocGECmuQuYlwXqljcTV93/3e4ZJ/3iMVbYFI3AdtyeHzSKqHhk1Dp+U=
X-Gm-Gg: AR+sD10w3Bqnx4g6kYETqc0T8xY5v94aIgb+/GPM5Pmf9ee8UdDXjXo0h1h6V4LxZ8p
	SQgcwKaGmjgYihiMc3FIlIvmMEKc+SI0lSuSzbUKiN2g5jQXJLIW2Ln6He7EOlY7Nmu4HVgID4B
	2hrfugN1nVWHWpi3FhqkcM7xwWda8J+0PYLVs7gIcrv9RN6ErkQUrxIXO+Pvlf8qgDBZ4kpGrc2
	4y9H+48RviaGsGZYvopDB1oIySeRypKgkoEBdWP/c1QwARLlOheh+s6aktIWH5bRKO1zyjGoKgV
	7nWCa7+ebuQVRwUPPiZJwPI4MTYmOZM+DjlzXEezA9O2N3Ay0sPrxoK8Eok9VoKuK/UZbsqeBMp
	Df+dGUo1ZJDNmC6BhokjSCdbbaBfgOWQ8LiEUxvVUXFfQvs2hhtJos3kwoFSfhEmXe8S6quXRp7
	Eo49dyNEG8GGzNLbY92mguNBuu3QmY7iRRYY9cV1LlRHMccSyfJEI9HO0Hz5IXWAk=
X-Received: by 2002:a05:600c:4fd4:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-49cdc59f62emr31062355e9.9.1788191856435;
        Mon, 31 Aug 2026 08:57:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b425sm1740195e9.1.2026.08.31.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:57:35 -0700 (PDT)
Date: Mon, 31 Aug 2026 17:57:34 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, 
	Sebastian Chlad <sebastianchlad@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests: af_unix: skip scm_inq tests when SO_INQ
 is unsupported
Message-ID: <apWQ7IRq5nQQTMnp@localhost.localdomain>
References: <20260730144652.5715-1-sebastian.chlad@suse.com>
 <CAAVpQUCkKUa55gJTqObD_6RNLDVdXqaak7Wst8o20X4RDnSmQw@mail.gmail.com>
 <CAJR+Y9J8d2uCN08+VYmsa4tKC7G5joM+DwN+PbskVDjf==A0=w@mail.gmail.com>
 <CAAVpQUC3L9aUdq7M2bReCEZ5MPLPSHgC+VjzFboWdTbG=CMV=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wynrhtxyneu2ctj7"
Content-Disposition: inline
In-Reply-To: <CAAVpQUC3L9aUdq7M2bReCEZ5MPLPSHgC+VjzFboWdTbG=CMV=w@mail.gmail.com>


--wynrhtxyneu2ctj7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH net] selftests: af_unix: skip scm_inq tests when SO_INQ
 is unsupported
MIME-Version: 1.0

Hi Kuniyuki.

On Fri, Jul 31, 2026 at 07:53:59AM +0200, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> Why is this selftest backported to the kernel without the
> functional changes ?  That's the problem.

Let me join the topic and vouch for the changes from Sebastian.

I consider there's a scale of selftests from validation of bugfixes to
checking of features. Another axis is the discoverability of the
supported features by the kernel (none ... CONFIG_ check ... runtime
indicator).

I've found it quite useful to have one set of tests that can be run
across different kernel versions (think of stable kernels), the
maintenance is simpler, sometimes even same builds may be reused.

Occasionally a reported failure raises unnecessary alarms when it is
actually only a missing or disabled feature.

So when the behavior is on the right side of the above spaces
(feature*discoverability), it is relatively easy to add a guard in the
selftest proper. That is something what've been striving for in cgroup
selftests.

Obviously, the dividing line for a good guard is not always clear cut,
in such cases it remains up to the interpreter of the test output to
decide how serious the failures are.

Here I think the ENOPROTOOPT are suitable for the feature detection.

Regards,
Michal


--wynrhtxyneu2ctj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCapWkaRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhtbQEAqZPxDBfw121tbW0sSS5d
2qdWdH346VdvCaPFJm44xpUA/2Opf98GI7pBHhQEaZedLMLdgrYmZeecIiCm5XAi
B6cJ
=GAVJ
-----END PGP SIGNATURE-----

--wynrhtxyneu2ctj7--
