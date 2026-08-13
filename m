Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3A2609DC
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582674; cv=pass; b=AzjHPodarzpBwv6/jeyPGA0A0b57Rawi+0I8PS8lVaW2Fkr9qK/Up44Fb/c67VRwH0NPv+glQ0CvDJPKm5Nod7IjHrqPibt90aIlRxMJ1c9+e/x/OC7uTNIN0ixCG2kgcIOyl90jEQDDQ6oc6CXRXhQjD7sSjwUJC9ri6Ta8FEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582674; c=relaxed/simple;
	bh=vVWZ+H3wIIIUcAqYsS8SRGoXGvJPtFF6HaAIUB5u2to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AME7RuoZXME0zN4Mc3aLijc2j+/Emb4dgBXAW18/obyTcWXtgCLeon/N2CS8zUoPwrVmp3wjc/hcrnNs6ErLwqXUPicBwzo8SE0e/GpAuBTG6MZI/FXm+oKabBxDtpZV2PmfWvgCRW5ZehxKo5dbzptUSOGAe8wcmNqzcA9f3yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3W5Du8b; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3W5Du8b"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1677c91969so23117466b.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 17:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786582671; cv=none;
        d=google.com; s=arc-20260327;
        b=if6imqkQxI62or7Pwvump06m30qqmbdkr9pQbit3fhirxKu89xnP3+xYVvXemgohYt
         X/lo2CxeWKfzUCgVVag3k/2m8dOzivm71LaaKj3M/Kvj948G/NeRF08sPrigNEFwnRs4
         ovJ31K8iH/UdtzSLBSHkAWVVsTxZJBqym23I2b6oK+yXe+6zGStcWRugKo7ATt+P3vlk
         98UB6EL/8xnMoKaHZ5LUXN3gSR5daz6Zz+0IynYuKFTRm2M6CYxeGcuaresQz6QLOpOL
         OR9iHfp1K1abSVY0RRucHkjUMDRIWCweZWdczKGufTSMTK1GtvVrjfkYnQTzU4t3w23o
         HzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bkwCm0Aueu9W7gOTLTnMM3HFp8P78TjAmm97smUID6A=;
        fh=d4BY1EbaU10+K0Owl56VHsEqI5HB5FNeXcORCcray7M=;
        b=Tsb2lO1PmlRcueZhiII/U50PGELfa2TP5H2j0qGU8U7EoOZix3PybEPUxkm1Jfa0X9
         b2AtU9gZs9qnsS/tCuD8UNNom8YSkThiWjZkPwwAkwbxOu01Y7jQCWY427ZWIsnEKSus
         2ltM1XVR/gkBcdgAJcmQJzGOzj5whDUMKNlGdxWnugHUqIThg30EH86lCI+yoGuRcm4A
         lN63bEZm9u/dcq98FaEv7o75PVfsjPdFCSGeOzOJcHJmqYkZSeUp3v9i0ZJyCjsMPxHe
         m/g26TLLY6eWgW0PhXZsxDHTLt270ayW1iN4DBiRV5bhEI5uVU7svehEZdSZwXlsJH5Y
         sCIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786582671; x=1787187471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bkwCm0Aueu9W7gOTLTnMM3HFp8P78TjAmm97smUID6A=;
        b=f3W5Du8bXdjK1X1/fT8XNGq87+tQ/kM+4CwK2xJ3qcVkEzot84cA+9iCD4QfFKWc06
         TAQgOZ/2NCb/QqaAIJsjQClIaQH3WJLlyjWWERzjvT0oGbexNlhz+/jsWwnBYPoskkMH
         U5HU1QAfXODK+HrKTJyVlF71yULCCZLs0orhph4cNdpwLSNYPzH8/UcpunE/4loCsbn0
         hNIrHmujTmA/zRK22q39ZzBRBRSguFqr8JDo4/eIczmKNR8cxfZwxLrHtDb/LFGUG1xr
         ara2MttdEoM758fJc2/7VK3jx1vOrwOnhx+H88aPGm1pZbQT6d4A/nKoFN+vhXdYzTd3
         gy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786582671; x=1787187471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkwCm0Aueu9W7gOTLTnMM3HFp8P78TjAmm97smUID6A=;
        b=iJeu21uPIhKnzebeB4eEGpvTdWUP7gHItPCbRioSn3sTYWXb3eGZ1DoqOLCWwvZ8xa
         uo39WvEB8wSWSPB4AvMq0V9mfuDeFOFjWOxkP6KXzjKn8lnlff+NiYOzp93LS2NbhurA
         67xNUDdFy9X3iIgHw8Wdc5O5EpXNWrr6sI+BAc6W1qkFjaaaZV+mq6ZupNvqMuTLQkcB
         o25dGBIWjYZdi5t2H35olne1MrOQBMQOdfSgPQblT3dd5FKpsR7sM7l7tpbIZbvLOTld
         6yLWkC+bQ06pWjrjN2mcK9MTIGm/5IfzqIlF61odlZ2fmYQDy/6FhCwN8VSzvnbTDy4x
         uxtg==
X-Forwarded-Encrypted: i=1; AHgh+RoKG51FosRGlQXz6DKNQnWfBq5jZJWIZVxX5bdPMwyWugrLDpr0dMGzv62CssJLtI3Kzr3OmIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdof9aFX8kjugUFM/Eueps8jXHZr9Rw41mbAvQ/zd2ZAV9UWl
	O2foBK8zgO+jXeEAfijSsHef2PK8B0YmVDMA56WW3HkDfT0ltBHpQhcD24xb8AGo7hZpxAf0GdK
	rw8YJWGVEPKAmD07PUI1GxdlpRWxg0aUaTPe/QnQ9
X-Gm-Gg: AR+sD13FmkaPJbMzOJSlbtCWc+DL/2ECeqqlVS6tLw5dNqXBpTD18UcLO320tnRnATR
	FqaDkkk3gOEgrWpsJAI9EFSW3U+r0h+KflUs0GNSrhlu6qjHnA7lC6DEk10s8H5N4mfbKKjP4nE
	sIEKSMTM7EUf1qf513OjTR2XMaVzOw6xZrb0oY7aFEKlbHLj2o6bhm4u13ux2INrYpGpXW6RxSa
	/jgDBSrdwx75ORUXZkjiGkQlR4xMQ/7sEuqIIF0MQ9askJ5BS3CHPP+8UwZKmACN2qpl+iVXiSO
	rRBKP5njAAF5exNyRfhzp69vzl1WQbeXnhQ/z2PofrY=
X-Received: by 2002:a17:907:d25:b0:c16:73a0:c4ec with SMTP id
 a640c23a62f3a-c2109038454mr93292466b.18.1786582670712; Wed, 12 Aug 2026
 17:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721063829.7d9e6c7f@kernel.org> <CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
 <20260723103607.55debff2@kernel.org> <CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
 <20260804072522.784ead37@kernel.org> <CADWJPTuxT4Vh4ja_5Wza=0Y-XW-xVh6DwEBVfKmXdBoUJKMwRw@mail.gmail.com>
In-Reply-To: <CADWJPTuxT4Vh4ja_5Wza=0Y-XW-xVh6DwEBVfKmXdBoUJKMwRw@mail.gmail.com>
From: Sheena Mohan <sheenamo@google.com>
Date: Wed, 12 Aug 2026 17:57:38 -0700
X-Gm-Features: AUfX_my-xynCFjBgKLAoNZ44kVdDl1yRZhV_39Q-f2unpdyQSKi1MVlIm21kYIo
Message-ID: <CADWJPTsC5GA=tefJjiZ5mCo2xAm+K2OuKng+BUf4=_kW4hacvA@mail.gmail.com>
Subject: Re: [TEST] google runner needs nested cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 10:39=E2=80=AFAM Sheena Mohan <sheenamo@google.com> =
wrote:
>
> On Tue, Aug 4, 2026 at 7:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Tue, 28 Jul 2026 10:07:15 -0700 Sheena Mohan wrote:
> > > The recent updates have been merged, and the tests should now report
> > > sub-case results.
> > > Please let us know if any further improvements are needed.
> >
> > It doesn't look right.
> >
> > https://gve-netdev-nipa.static.usercontent.goog/json/results-2026080401=
08-88cb54ab-ca48-426b-9c9a-50bfbb0de32a.json
> >
> > test    "napi-threaded-py"
> > group   "selftests-drivers-net"
> > result  "pass"
> > ^^^^^^^^^^^^^
> > link    "https://gve-netdev-nipa.static.usercontent.goog/results/202608=
040108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a/napi-threaded-py/logs.html"
> > time    20.788391
> >
> > # selftests: drivers/net: napi_threaded.py
> > not ok 1 selftests: drivers/net: napi_threaded.py # exit=3D1
> > # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> > # not ok 1 napi_threaded.napi_init
> > # not ok 2 napi_threaded.change_num_queues
> > # not ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
> >
> > Does not look like a pass at all. Subcases not in JSON.
> > Not sure why the subcases are listed under the main return
> > in the output, I've never seen that.
> >
> >
> > test    "psp-py"
> > group   "selftests-drivers-net"
> > result  "pass"
> > link    "https://gve-netdev-nipa.static.usercontent.goog/results/202608=
040108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a/psp-py/logs.html"
> > time    341.833939
> >
> > # selftests: drivers/net: psp.py
> > not ok 1 selftests: drivers/net: psp.py # exit=3D1
> > # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> >
> > Again, doesn't seem to be a pass??
> >
> >
> > test    "queues-py"
> > group   "selftests-drivers-net"
> > result  "pass"
> > link    "https://gve-netdev-nipa.static.usercontent.goog/results/202608=
040108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a/queues-py/logs.html"
> > time    686.483495
> > results
> >         test    "queues-check-xsk"
> >         result  "pass"
> >
> > Okay, here we have a subcase..
> >
> > # selftests: drivers/net: queues.py
> > ok 1 selftests: drivers/net: queues.py
> > # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > check_down
> > # ok 4 queues.check_xsk
> > # # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > But why only one? What happened to the other 3 that ksft clearly saw
> > since it enumerated check_xsk as the fourth??
> >
> >
> > Something is mangling the output on your runner, it seems.
> > And the parsing seems off.
> Thanks for bringing this to our attention. We will look into the
> parsing issues and work on getting this fixed.

Latest test results should now cleanly report subtest results.
