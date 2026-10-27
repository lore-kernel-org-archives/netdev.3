Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119573;
	b=rq8y11oztTOQovcTyRYxalDzMK9JYIxVgzMaQ3966unryVCu9rMtDlJdAuxHPDjuKh/u
	 1T24qCn2xmpyhXrak/40OYF/myD7Ba7cdIMFyBeGA6iMRWn2x6EE4JB0WBS3ZIDHdLw/V
	 g4hzvBDwapP7vBUvmm6wpS646/kzajAFAHG5dOlyEnF7SpDyj+R500/9rsw+Kn2VtKkEy
	 Q2+fhQpUSGnszMFdqQ4OaA3x5JUVV8I3jI/stVpX8CG7TGkwDrEvLbhl9OdZ9ExZSMxfG
	 wZWxV0TTisP9NB4LyIXyvXqPWe2ko9nMAiWgSRpjOiNO5xkMk8o5QLv1OeXpsvIc4Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=ULD6mg2UF3aqGiRVnTtgMfjAq+CS0Bj3WcB7vl1Q6SE=;
	b=0hiVRlltxwo9sVeoKusAS+A/Y1kp20TEBD24Pf0LDW6y6tueSyvhfnxozl+pZOJHpgYj
	 4pFRhxWJs9bCTdK0kSADpCCFUXqWtQgbf034K5GCuU6kuK1gJh3aKXwyAG0bvOk4azkZA
	 ao3TbHN4UMDZdDgVM37aSoRxA7RW5WKzr/AGx8uLUgluRDiuzXj6nmQq8xEX7gLbSm3Wf
	 O+s6grsYSTjUlHIh5DJJ/abIHoI7yJhZy05cXtpfm/oBzHqEyDtd8uEYukUX+AHH1d6bJ
	 uOZnLSBT8nQzfEfJK4MzYD4DBKSivLNhYFWORmnq8Dr/Tvaf0WF4pgCsO7S0/MU6JpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6c5qIvw;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE1606A339
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 16:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCDE1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6c5qIvw
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so99280a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119572; x=1793724372; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ULD6mg2UF3aqGiRVnTtgMfjAq+CS0Bj3WcB7vl1Q6SE=;
        b=d6c5qIvwE3V/cG0JsfhmIWnhvHTGilA3d6rRGHpFtN2pDCjgYwTtiF6MKaIQEa86tr
         nlAW0FgkGspl4soDpJ1hdbeLXGpx2T+VHmKZgqr7ehw+5rifVKJVaTDzRwDk2tW8zU55
         /5ZjyFjP39zS6iVMQ066uQFFdViUSG3Atmp7eC/wlaCgODLvZ8eVhWTruqEVEQkEbcT6
         jNAJc1nNY8c9uNfaSWXKEoN8ADQ3dGReijp18oPUc9W1gDySmMXRLg/CsDpA/G0YkkbA
         GS5NBxSc9KFxAV1CilPPCWWgGzJ00QhIm5vm7EKEAmyz9lu5NQv9Z8vvPz4OKx6jKPqJ
         lGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119572; x=1793724372;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULD6mg2UF3aqGiRVnTtgMfjAq+CS0Bj3WcB7vl1Q6SE=;
        b=PxHVA7w8VOH6Hr6Dkjgp306mMhuUNyJhadCBav+RK+kk3uZvuiHMycKJHD1scxiziZ
         +6uxrPVWpw5jvWwiVmGXgW1odlIWYoR55ScgEYyQjeiswdl+T1Pl91V7XsKMHStMb/hX
         ZPtmiMQczDcHWzXGnoYHRP1n/In4Wv1jbk/jHxiOTGBCSyJfO0/PoZsi3YDUZxZ9Ko+t
         XsjdtQxDEDVdtPYAJ7OlQ/+f+AdD39WXgHg+2tWZwKRVsl76cynHCS+eQYWhMzqbfBOk
         r4+d1FoxdiN7w7oYLu4f49wZY4I8exv1wZ7xpBBaokLc7olY9hXRb0nuxbdW0b2ipceF
         Fo1w==
X-Forwarded-Encrypted: i=1; AKwUvBzMXhyDQ/nKCsfpDRIATvQk/Eh/e4eg4spZAyzJT0/yeS8q0xDG1uBtNR8lA3/o4FNKsnbkCbk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWaMV+QUw07wDECbnBe0KOseMezFDKm8xAoIPLbtybn7FE6CaG
	kXIQRA9Blc+UJ2QiyPPIgagKRiPYxKOSAq/+TxvShcS9ybxCbdUbmjmo
X-Gm-Gg: AYBFou2e/z+B9pdymeIzPXhN/LpSOH2gEZ1E+ovhJn0X+ZnLbDiItF/q0GguKvZAPak
	eCIphXo6xaqqK37a2U/N75PQylBiq1CYQpYQUlHjxWH/vPZa76bxhtAdNnDDGx6Yf78W1D53Leh
	6UGtgiAET6oBIH508t8OEQ0UaCwGO1Xq+CQtoBqzjNK3qyV7OAUx3Dh/2OdBsMheJwky4DWtzw4
	ZeYQFgBeUtyyZl9MVUq4T5+jYn6jlnYmiW3HzanbF1LDH8mqgl+qUaRER9bN1vlE3nbbfpDg0ap
	L30MWt6n7sIPU7fEo2oXQ4Vv5c5x5Txly6V2+nZEyTLyR+h8xFb6Wc5RH+r0ECqZalZwjWH1CDo
	Z41ijcvD0Et+NapHM62H/B01Zf9/v5VOR80pNlit9bKJ82biOxrLT2f/abxtXy6zdZXbc6ctKuq
	7OfmIQcccHdYLahcKMLThxDRXBd+j71q49ymCtL69n/ibPWvjAkRpSzKsfVJmcwX1quipg+iM+x
	brXWdtHaYGjtbvloiwZW3I9qUEt4cr65gtjbwwI0ld2gDq3W+JZSgsoPuK4UpwU+JZjP5HTBuS5
	mCmvpHtajpSja3R+isMtBwgXUDEBD4VXamlTx27uU5FAZ1d6ElMvBW1diS+n
X-Received: by 2002:a17:90b:3e4d:b0:3ac:403d:6232 with SMTP id 98e67ed59e1d1-3adeb120167mr9427553a91.55.1793119572168;
        Tue, 27 Oct 2026 09:46:12 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404274b2sm4410849a91.5.2026.10.27.09.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:46:11 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 16:46:11 +0000
Message-Id: <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "Network Development" <netdev@vger.kernel.org>,
 "bpf" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, "phx" <phx0fer@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261021155629.68813-1-phx0fer@gmail.com>
 <20261022054811.35008-1-phx0fer@gmail.com>
 <DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
 <CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
 <87v76o63qv.fsf@cloudflare.com>
 <CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
 <87pkwv5cj8.fsf@cloudflare.com>
In-Reply-To: <87pkwv5cj8.fsf@cloudflare.com>

On Tue Oct 27, 2026 at 4:33 PM UTC, Jakub Sitnicki wrote:
> On Tue, Oct 27, 2026 at 01:10 PM +08, phx wrote:
>> Sorry for the long silence =E2=80=94 my laptop died right after v2 and t=
ook the
>> local mail and the working tree with it. Agreed that the ordering fix is
>> the right one; please go ahead with the commandeer, Jakub.
>>
>> I do still have the reproducer (a KCSAN selftest for this race, verified
>> in QEMU). Say the word and I will post it, or send it to you to fold int=
o
>> your respin.
>
> Feel free to iterate on the patch once you get your dev env restored.

I very much prefer if you Jakub will take it over.
'phx' is a clueless bot that sends spam across all subsystem.

