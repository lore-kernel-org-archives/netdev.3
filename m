Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C093BD64D
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114348; cv=pass; b=rqbaGryPeTqiPZdkBVT8aAnYVt7fMXyvKbIy3mkAQS3l3GGzE23J8j4S9eJ44z2ANh8YHtm682cAAykM9pf+CFvLBCIwEsJWkcFmuZensGPD7PDWxzf67j4OYCPA0A1M2yBTIOzXhn3pymC6Tw+/5afSWkB4iM97+zJ2G6Y4T6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114348; c=relaxed/simple;
	bh=2YFtbpGvHFPEXz0SlE6HWTprCagTt2rI+xXYcmOCXjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtmdHlFxL8WH+aYxSV40XTWcwBNu8vWRHPdDUm6bzjnqm745zLkNIFdWXdHEzg6Vp729Zn7j9SbzMJmPNzJXxS9s7OFYhKAjrNckOy2ue3Qwyu6/CrtwV3s4D1QH1qWuqk9Ujo3I3rRPO1FodHow2sBkpYzwPP7dwc1VVGnM5mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEdoq50y; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEdoq50y"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52fa223df07so22683271cf.3
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 11:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788114346; cv=none;
        d=google.com; s=arc-20260327;
        b=hfvIi6z7m7NRX3cg8zJR15BggKN2yeZlNPCt0hfXOydCK6OSdBd9nedrOkc49LFctR
         +9ivhsmMp561VkoWlKxUxWCdKxFsBpqauiutrrVOPBsbclvEk9CYr7Vt3BiSpthYSLy1
         zT4Vp8WRv6Kh1FaIbMUvVdq54rUDFs5SLEOgHnJBochQCxZi7hs26umZdkrXWq8L/5Li
         K4XIpxCkBbKXDHfLZsrcr/lQkY6n8lUasFa0mc0CcM/pkBP5fV5lJOHtg5+/eVFnSRA0
         q9ZlcSBN++EWcEdoDEEDcmy93K6VxVhWF2WTHM3V28KJVDlI0cs7I4TlqbTv77oqxQrj
         X8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tc+n+YHbaDdvHspo5Gs93QoIH0vrtoyetWOp/9Pot/E=;
        fh=HtXM9Ae+bAj6+jirk2UW4FMQ45grqGmt8wpheSMqMhY=;
        b=VQzTS6cOYCJHquckEGxmeYZnvJ2XTYERd2RyeHv3sHfQUWAUbQKjrWa1Gk1wG4FT+o
         JOPw/K6RDR8XdcIHl/ams6jq3JDX5p0ZTTskAV9NQE7Bfh9lkghVS2wYP4iLz11iIFVC
         0j5NSDbsRxvopZ/EWCKjWcKxxfcX1Yiqf2yHJjFMWnf19GRozQioGg6jDVaT/KyaLYff
         MyyDcy35YGF4k0dQ3fE2iUdb0efO+Ce+fP/KJ/dONpAqPp6LpnQGc/gQlkB+YjDjP2Vw
         GlFI3RtCxe2j2Vh/3bT/yjcEh7Kv5BpHdIUIkVYP92KBhh4BXSU1WZ61XWlR89b349MO
         fCDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788114346; x=1788719146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tc+n+YHbaDdvHspo5Gs93QoIH0vrtoyetWOp/9Pot/E=;
        b=GEdoq50yJTgRiy30ObCi0dtu2Kxt+Ja4/YVW/YrbOU44HP1nsr4Ogp1zyFNUVt6BcT
         cUJT/PsFd5MjnxRGGhMpucXxHZ99g6dzYEHIbTBIzKCtpMDNSNyJnGhjI0OfrbM4iSKE
         RANmtuGjdzxklFVwnPlXKPvMIbHnymoA2eC78K90QVaQVTJoTdVyXHI5VW0KEeuz8SfK
         eSw6JOOEHSQqnFG3mn1THo+K6ZJXZWLLRyfZx/l6Ya9ynvuB72QKZzVkATEZaHqc1BZV
         ykfKCy314JRtc1WOj02me+R1hDX3yXs+uSBlvAADc/xpe/d1K+hJnRh+I1XX2VPItdQj
         DLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788114346; x=1788719146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tc+n+YHbaDdvHspo5Gs93QoIH0vrtoyetWOp/9Pot/E=;
        b=JWyxxZHSFIJOrz+QzGVQETOMKK/bFwaCqwgZgXLpB97F4/z+tSA3NJpUhXtapKtrZu
         kmprT/sZaPqycLINN1GyA1d8NTVnLO/NTUQUOItE601Xqy74cIsyALVLQv8kKnhbzkVa
         glmdXKadZOcgzy/LjnteILc9LRvU9lACxThKB/p9gm9QscqWfE7dsL0Yb6INBaDDpbOf
         9H+gPi5hxbJTjyd/I3i/lr7T8aqvNtlCFNDwyl5B6aWJoneQVjnL+yH7CBPSQ7ZCGOSZ
         xjZykzbkdSBVVP59fRK09JlDb1dmrXdzd0catMXeh1QsAfyNRZGxCK8H/qzlCixjgZxx
         r2lg==
X-Forwarded-Encrypted: i=1; AHgh+RpvgkwxjXt4jS54WvVkmV7PqTa6d8vR6AIjZM6Zn//Ovr6AlMD33+7TOq759uhWEwZwFysKtDk=@vger.kernel.org
X-Gm-Message-State: AFuF++nGU6Zc5iDxxHsNQ8YxH5w2nupXxJQsNFPxrtGtR2yiuXgFrMu1
	svNxZzzMaU1l1ee/VaHcuzrVOc/3yUrsNWLnA68WSsoHKVY7FXng7atQTl4JjpVGpgBaNBxx8St
	YOb0LS2eJVhzBzKGmi1HecrFdD8wRFWlYfBT4jtRR
X-Gm-Gg: AR+sD10ih3uE+0EWNyDsVfv9CxtWh46JZIInDeDglfiQzmX5JiK3R33GJtYM97kbic+
	JrkxGccuQcz6N1/JY1usyvd8rFAMmSd8DfEOJ0C0cW5nxPxoKwivZEv1il8nJwJMfiVhvXt9Bq8
	GU+bkEkjPDurb/6eeEpZAWDFo7KMdMGQKZOb5LeI6T4w6+F/QvQDDJj8IZn5dgofL+GYOZVRGHQ
	3FYsgxvWAE+h2dFgAt2NnRvPNAX2hS87AYjszUrqm/G301/HYzfpmr80nwXdDa0VX+dVog098Tf
	EME/d/PZW/uHIOb/w3cyQUYdMkfwS3bFkKQbw3R2uazzdK6TLWSjdZllO10KQGSGlPGRNr7QC5K
	jUxxyO+MKtQHnVNsh2/yTBlti/Rrm+tuTcuRe7+mzEh60ukllAQ7JaIyLuG8O1cWt3XMeEA==
X-Received: by 2002:a05:622a:164e:b0:52d:953b:2c25 with SMTP id
 d75a77b69052e-52fb965ec83mr223789331cf.38.1788114345425; Sun, 30 Aug 2026
 11:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830180915.260225-1-kuniyu@google.com>
In-Reply-To: <20260830180915.260225-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 30 Aug 2026 20:25:34 +0200
X-Gm-Features: AcwNN1VeDzxBfRS2UnOo33V2rqk9CRnkNoR4PSB_l8ogrZCvZ39n7vtjaHRGJPA
Message-ID: <CANn89iL9ujwPmw89acUsU-xQtu0_jUcJy+sRfuj=b0-k8Qagfg@mail.gmail.com>
Subject: Re: [PATCH v1 net] af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Johann Baudy <johann.baudy@gnu-log.net>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+73df3f89e1e13089e466@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 8:09=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> syzbot reported BUG() in sock_sendmsg_nosec(). [0]
>
> The problem is that tpacket_parse_header() casts user-provided
> tpacket_hdr.tp_len, which is u32, to int.
>
> If the length is larger than INT_MAX, the following condition
> in tpacket_parse_header() passes,
>
>   if (unlikely(tp_len > size_max))
>
> and any negative value can be returned to the caller, up to
> sock_sendmsg_nosec().
>
> The repro set tpacket_hdr.tp_len to 0xfffffdef, which is cast
> to -EIOCBQUEUED (-529), triggering BUG() in sock_sendmsg_nosec().

Patch looks good, I wonder why we still have this awful BUG_ON(ret =3D=3D
-EIOCBQUEUED) though.

Work done in 2014=E2=80=932015 by Al Viro and Christoph Hellwig was complet=
ed
more than a decade ago.

Reviewed-by: Eric Dumazet <edumazet@google.com>
