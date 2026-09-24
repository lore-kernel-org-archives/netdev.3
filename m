Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C13DC4C2
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266951; cv=none; b=LoUWXHXyBBYLV13i3Un+JTiT73NCX84Rv2+HB5TxfhOF4pgc/O1xasR698RSqQCiEMkaEkS07M3B4yu+vni1Gi7YPOb4KDwJUPO1rRPidMsheQsszFX3yfgtL9QSGYRErrhkWmtiQFIZ/Et5PbEVPckuBiF9ZaMmNp3XHop+WKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266951; c=relaxed/simple;
	bh=eFZ9P9S1QBRJHJr6dZQmKd+qYALkIC8DtqaHa/g1I0c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ATtCQK3Re7t2OcpVF0FfmHz3N/op8PHgnGZ5t+RxGBul2j3HpcXEyj+b2vIYHc/nX6DMCkSrL82d0yNMe1rbeGUouDXQ3cI4bF0ny/GJ7eEwIzLE8SuaJw9WnJwTAhp8nslMQbq6SX5+6OeXX1AQjxltyni3J9hSQvPHlt3RtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNWJPl+9; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNWJPl+9"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43ac6090so34224807b3.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266948; x=1790871748; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i8/J+pxr/d/k38D5kAKE7gwMuHkeEk36qAmV1V7QTx0=;
        b=WNWJPl+9kSpzvM3tAkK3y8uW2TmbeZLfYkXkTYsb45DgkPrdzaCXYMRQ0RSJ2u8f0g
         64PcxDIvrvg+MSvJBMasZEhWoShU2X0O+ruo0+ydmyHuAUsC2Wb1ga3LwKXcBga0JGjT
         k3r+mN0V20vR7zyWvtJ6SIHP4gNCspYdTtKg0Eydmb7An1mUFO/6VqtqT8riCHhL5GKy
         B6iUMlU9hebd/Jd8h7ogCrUXLjVbQ3OKdtiMHcQN1KISC/4ivCUsZFgfsJ1RUfUs3xHt
         ZROs5bkMt55zbV053xqee/LF17f/4/YBkB84NFfZnw0OQXk8YlCmX1/0wnQ1eRFLVZRu
         9wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266948; x=1790871748;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8/J+pxr/d/k38D5kAKE7gwMuHkeEk36qAmV1V7QTx0=;
        b=qANpV9Rfhm7IHCYWr3iMrPvqGva1Ajv3JfgBm2DxkaAwoGUKaZlSkSoDyGXr60agWo
         sZBvWAqQQ+mlyKenut4BzJ0fmodzHbx/TQQuyEeGS4H8cozXp51Oq5fSPkbK2fkuPbIA
         LD4b7I+B3jyg9RpdIR+D22UK8MkCcDwxqYyUAQjTawlNcUJuUcHtyZzpxMPOFEGzxYpy
         RfsE85jC4QIN8JDI0ptxoMjmYXFMYMXKHMo1uwEzY5xpvskDoStrPcH03zSsl0Xfn/Ot
         mj/Gui/D4HcQXjJqJXr7PB8zx7wCSx4sJOZlcb/l3KbihIb+ITmPefD1X905AIBmN3cc
         No+A==
X-Forwarded-Encrypted: i=1; AKwUvBzBiDf2mL4pP5PUJXwfkTN/HtZTW/BW+zMXJiNslQ0hY8J/w+H4VdAxsBCCaJV/pUD5QUwOgnI=@vger.kernel.org
X-Gm-Message-State: AFuF++lE3STbw4wicQuWdAbRsngNX4EmyX0AgtllO1IZgtCFN2y2S1oN
	/311FbM9kt0pxtDjLR/RfU+pH1EDlNnMxMu6jQ2FSYSb1ktWa+1dd26I
X-Gm-Gg: AYBFou1s5Lv0hCx0XnQK5POKtr0XmzZkxD3djWnf6j1mJan+ngYT/DT/7uugDudlyjz
	sJu5Uj+esTkyxFXHRIcfNntXCzTnWpo9dMv0Our2MaccmgxI99Gr4Q4/Uj7X5Y9iNwXDeZiW7Mq
	pANyguXIKW3f22ZfG8ZRx2+PUWv2KLX6cUAB4HUtrEyWHfQCRd2/V+ToqLenEFFo5uSyJ8friqi
	QMCznmJ5UFb88oSbOC8cZxVWj6MKE+vYoUgFLE0gkQx3CkPFjDyfTax3pcYcT51MP10brmCQtWq
	pmn9YZbTH+rNq3di+bIumDavWKsUusapOKhsn3pqoRlbAvcbvxu6uu1xUCMBArnDAFDcFOOTlHh
	PMMr9weljh+XBfuB7UbIqjF6OGVA1i5kTzlXB9jtG4W2WL9uMpteWcI8oDQTJEDDy288++ZFl3d
	JF5SHacPniod4K+91nhvWavtHN5jRAV7vJx5oGFoDOFUQOlV6+gEJ3H211TpBGGKt2TMNBZBAJ4
	eHIFq/1poV7+2gFvfbUdQbz40je12VhgB70Toh0YLClGoLMbXGV3HU7OgYaKMRG+0ZEBQ0leqIy
	dzE=
X-Received: by 2002:a05:690c:6607:b0:80c:8d09:3880 with SMTP id 00721157ae682-8a648ec365fmr21043007b3.15.1790266948251;
        Thu, 24 Sep 2026 09:22:28 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a6522ce69fsm10391847b3.27.2026.09.24.09.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:22:25 +0000
Message-Id: <DLNOO145D1Z1.5SN8R6EWX63J@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Mark Brown"
 <broonie@kernel.org>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>, "Networking"
 <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <arUZ_0CU-Zlct_Tt@sirena.org.uk>
 <a5289901-6eff-4c0e-baad-9351817592a1@linux.dev>
In-Reply-To: <a5289901-6eff-4c0e-baad-9351817592a1@linux.dev>

On Thu Sep 24, 2026 at 4:12 PM UTC, Ihor Solodrai wrote:
> On 9/24/26 5:39 AM, Mark Brown wrote:
>> Hi all,
>>=20
>> Today's linux-next merge of the bpf-next tree got a conflict in:
>>=20
>>   tools/testing/selftests/bpf/prog_tests/cb_refs.c
>>=20
>> between commit:
>>=20
>>   04ae4ffc57a6b ("selftests/bpf: Check callback map value lock identity"=
)
>>=20
>> from the bpf tree and commit:
>>=20
>>   11300f54bd887 ("selftests/bpf: Refactor cb_refs selftests")
>>=20
>> from the bpf-next tree.
>>=20
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>=20
>> (deleted the file, which probably lost the test)
>
> Hi Mark.
>
> I submitted 11300f54bd887 ("selftests/bpf: Refactor cb_refs selftests")
> yesterday to address a non-code conflict between bpf and bpf-next. A
> test would start failing after bpf is merged into bpf-next.
>
> Deleting tools/testing/selftests/bpf/prog_tests/cb_refs.c is correct,
> the tests were moved.
>
> Thank you for resolving this.

+1

bpf tree was cross merged into bpf-next and all conflicts resolved.
Next linux-next should be clean. fingers crossed.

