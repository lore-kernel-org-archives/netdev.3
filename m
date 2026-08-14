Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9D3D8125
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786742249; cv=pass; b=JJhAjCRiUgqTwJfoUx3YGoJIO0081l02ubN9XX4KAsNzTjjWMXK/VHVOZWaGhoh8/KZxy48VnI4Kd/O6shIIN933acJ6g8cX6cpQhhRspO97SqB9So2zrgG60AH3hUEajA9cbfmE7edQKtC56kBHgJFLTqE9yZD4gyBq0fiHY/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786742249; c=relaxed/simple;
	bh=weqXldJIdnSFw7RHim4Ib/9v4hGZebyt8X64A7KIjlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoMOniBWer5UryCeeC8JhWn49bRloc13QfyBmrSjVVodUh3X7EetQ429Of3Cq2sRvUCyHKzJ/YEmdmb3bGBt+kWXvYb2SPk+NqsX1xg3joMQt5yFlI3FNfP3fsfbahs0J2jvuhRHaRrpd+coPxmQl/wkP02i4a8v2f+nofeY9do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1ynqKsi; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1ynqKsi"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdf36f63dso164175ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786742247; cv=none;
        d=google.com; s=arc-20260327;
        b=AoLnQu7UY66IyPTp3FzC2o1PWcORexv7oqNxaZtxwax7GJt6qauP2BCczMJI9WG90E
         IcSKouF2nYniZgBppJIO5auNKPYN6ii52V0Xet/OCQu1shKrvkG9WdzM8il/WIjCq1pl
         XcO4knPajkUWFhS4NjXC5wm9wvPMLjjD2WX01OmcMonZNAAj0u+W9eMA86fKgBnJMcl/
         BFh6fbSTXLqMP2P9XMYMkl41nD+JCj0OnGOegdRYO8xJS51ygulRDVDYArhafJJXqe6X
         G8xXtxkN6EuxZVs7Mh/CfeAj5Eh1phno3GM2KvO0Fg4L1g1r48v7LgfIEG9xSbl4kaFR
         tkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=weqXldJIdnSFw7RHim4Ib/9v4hGZebyt8X64A7KIjlE=;
        fh=yTYzHmnr1B5+GGzLzQABnUXmsXy/GUneDJ7UnyoZNkI=;
        b=pH/YV4+GSsD7rleQeIzP9aT4KuTDKT87TJe4zkZX0XfnAbrKrqEn3dzyagixLqX+8S
         gjYZx/OQ4/grDHIA3zuh1scioQnki6zpwJX7MEKXaKRr8zsSrq+SHH71DrS7hoLL05c4
         g87HYugItNUdVHd9klRiZ76r/kCAm4mIFX2zG7zXK2K8RPfHgfYWiqd2QtFRm2GbrEOR
         TKnrkgo0We7WJM6wqlpfIJBqFhV1eq7DMJdRZAQNZ6A0hdy3Fw6CuwAt/j4+8rNu39O2
         WO8DNflqyW2Aj2POGcBN4iH2psr54emxcJqIHfUvFOEEpdTjyoaReC7GcjPgQBlGretM
         MdZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786742247; x=1787347047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=weqXldJIdnSFw7RHim4Ib/9v4hGZebyt8X64A7KIjlE=;
        b=A1ynqKsihUIK+JD7zuFjbCnwoRmOIJ6r+3SI1kLXjGj/sukDEN9dKFgulFZEXqtuVt
         RucO37MvgVgGEL29gTE+DTwvPL1PQP7wfSUUAjbIn+w5vDrBpgmdD795KVq/uhKJOoVZ
         7oPgEGjH9BnTGXZEGRUMzmsffUfGmzIny5nyLmJMPvuU8DTdj16imCBkCpWBnWIircX2
         UZFERhizveP7CRZ5K8QENpKytQAuglLcL2j5TN3MeYxnBci4JP2M61YLSXcW77PyGvPq
         6M1S0miYrkY7ZXy7ScfYEj0AkP02B70n2lF5RJUX7zjQtRm0xc7TIgvjSpmYIqLEatLk
         jr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786742247; x=1787347047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weqXldJIdnSFw7RHim4Ib/9v4hGZebyt8X64A7KIjlE=;
        b=evFG723MBfrDd2HCvsg4gGyhZ4KANtdvzMOBLfjGiSwtxGmHlmni3ToKGFCPjRG8u2
         ijtDwjEgEUnDqn9RyxtndP59mximfhSagR5UBEycGDl4OqsJIIB9OIz0G95nf+wzK6PW
         W35u6ES/OElb3TqLzh4ZiZhf6g/u9cYO7aQgBKhLSlBOVa9eytIfW7gt8iZENquKkVP1
         WCwdWL6Sh8XRt5hBfa0VYmxr3ihQ/wFHfWAuTtv2XipT+f5YhgTG2l6p9+PUYC69oJtQ
         cEWW3AcPQi5zPSQI63VKXoIYaoyalm+sHJKkwqepwEeYJJXSETGjhO1btOCWYWS8lg98
         TqDw==
X-Gm-Message-State: AOJu0Yx2Xemnl3ol00pfn9sz26yFHpiAhnL3s0Eb7byPBFSDHHmE9luT
	4YHk69mfKr0dnfKmWtvwxlOPWO9nnOLn20PLtPwJ+oK4lD2q33gDT3Xxlbq0ErIh0uWZ5ZubPxX
	6QEj4BzmYlHmlDZH9c8pN0xdXtNclv0behyIw9bR4
X-Gm-Gg: AR+sD10nEEDi2CLGq4jKEP44P50UQwo4xW+yNmkd+O6iaJ1/+UOiIrjcv98DiJpSZzF
	/lNFXSpfopbSwVpMd6eQZ0a1hkYJnnnmfRzz6owGy7LvNPHN4S8sUtdhb8VFhjWhKVQjCHU1d9c
	YkGY5wrsOxqFF2WZ7j9eLFvexloKAK87+pv578bEyrFTRQiZjeVX6pA7VPm8dKYhaH0zCKu5UIB
	KjwINP9iuCYuNN9RTCDFqGCnO+C/YDa6EPG4Crx3jjFxw2wbThjozwcoF+N3OAYGlPgrw1POlJ0
	ocBCUFry5HuntqIqwyLcRI6yoAMfrEPzgBEFpaj9yhY=
X-Received: by 2002:a17:902:ccc9:b0:2d3:153d:acae with SMTP id
 d9443c01a7336-2d3aeb797a9mr11982755ad.0.1786742246677; Fri, 14 Aug 2026
 14:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803181852.491437-1-almasrymina@google.com>
 <20260806121631.13175f7e@kernel.org> <CAHS8izP=mgsdxv3AtjJo9JY5OHC17zeX-VbPPH_gFF=Ndb_qjw@mail.gmail.com>
 <20260806133435.38c34e31@kernel.org> <CAHS8izOU2pxfQH0Wo1DrqajOb54wv3Y1rMryGpwjNnoUsEufew@mail.gmail.com>
 <20260807145444.6acf9c08@kernel.org> <CAHS8izPQn6a_eUgeL5otUESTRud1COHXg2SuR5g9qce1xJogvA@mail.gmail.com>
 <20260814133943.45c411d3@kernel.org>
In-Reply-To: <20260814133943.45c411d3@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 14 Aug 2026 14:17:14 -0700
X-Gm-Features: AUfX_mzht8NILGOg0TkAAMoATbNVLNe_NrQHwRZTWSWRTEzdY2uBLBo45E3kVag
Message-ID: <CAHS8izPpeFTWw9rVW9XaKEf_9hds=Gh_Zsp-DCU7CVpPYkCSnw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: devmem: fix 5-tuple
 flow steering
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 1:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Aug 2026 13:24:48 -0700 Mina Almasry wrote:
> > > No no, I just meant a trivial test that installs the rule and maybe
> > > sends a packet to check via getsockopt(NAPI_ID) that it arrived on
> > > the right queue.
> > >
> > > You can probably extend ntuple.py instead. I was thinking yesterday
> > > that it's nice to have all zcrx stuff in one place. But in reality
> > > we already have a bunch of scripts testing zcrx so ntuple.py is
> > > probably better.
> >
> > Ack, will do. I assume you mean do that in a separate series. I'll
> > submit another series that extends ntuple.py with 2 tests, one for
> > 3-tuple and one for 5-tuple flow steering.
>
> Same series, please.

Ack, I will do that, but I had already posted this fix alone. Feel
free to drop that one while I work on another revision with the added
tests. Sorry about that!

--=20
Thanks,
Mina
