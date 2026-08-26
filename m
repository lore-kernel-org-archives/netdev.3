Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE00312807
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758358; cv=pass; b=Ikl2QweN5tofKw2PMocq2kWYKMOGxG7kFNMNRChHEtmu6eLus8w6SxWaiUl+5ZcQO9q/gfzlUCIqQFALW5PKQNiIg3OIeVbOAVv9jqtGeMef3ENey77kO+++Ufm3/FZRxELafwpxsEXkMneqewvzT1kco6/cis+3QgvIh5k/m4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758358; c=relaxed/simple;
	bh=bVyuZZ5biJvVEoL5OzeeKXfWr7aXMe9k+lRMYGHpFns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0+DVGY9NqRjxpKlKG+BjT26L03kI32qxZWThno1WH8vB9r5uYkud7rmkccLCnJKsfN9n0epD61grNT5NOU06o3L/MLGmjyrsn2WMzfAsetioztsCsK8HCgl4WImOuiVVdubf5bZ5PzAZ8B2VEcOwIPAhrhxX6vRVYd7AUQ+AMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syu3YEgb; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syu3YEgb"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52e2d1bdbc0so7995281cf.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787758354; cv=none;
        d=google.com; s=arc-20260327;
        b=Tlw7ftex5n6U1p1ZVNK9eoyQviFlsYWjVXMpsPRXPi0jty2ImPIuHidOLzb6K2u3V+
         +tlzVF+x/RTqMu4xelKZeVAX5moJAWr52mt3EA6qlEJA1ExKd+u3bKlEg02ixLo6b2Ry
         8BGN34KNIOazgVfVFAxXM+vcbuclhymRBzlS56/Xa6Y7WTYRuyCF+rn4DYaCmUx6BKIs
         K4qzaTsM4KLL0pwuSGZQ6Vbj1EEEvJalIxd7wiSIE0CPqwy6xo5nkUSWj8PthJSWw7cA
         zrnXcrmjbLB4B6R9KUIFvW25Ey5bfp7zQ3cwA1NI8IVi5mFRVDV/s1klw6Sh5+NDQLGz
         Bqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bVyuZZ5biJvVEoL5OzeeKXfWr7aXMe9k+lRMYGHpFns=;
        fh=yVzwutshZoy0kvNqL5zpg+tE7lKnE7HhPDhIxyLwCGY=;
        b=fyj2Yl/U3q+uHZg6LhU1GCXYJ7WQPwBOV/+lDIxMx/8HCVJyq1cU1d8L8jXZUnKqDF
         kJBpSXZiYW9sZM0JXigVVjlvh0q1fM4qW76z24kKo8dMn0GJBo5cQpyMzHFKv4zVKDHd
         txCMXQRzfCGhHCo6f+PkZI61ZPnMlcX66kyFXGxk9z7+iz36Vym3o4voCPhhnDIxXGFp
         FwxJPmpMN8GS7GMRJ/rmfqmMW8FxYPQMOGlCQDcRLcTMU74ypW82rzGuBVXG+xGUdpGc
         G0bdD54ded9AjF7zJKEgtmJj1GiHbGBrasoGu8vRu6ixbLcox0LV5jrlSqKo4bcNB47M
         zOVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787758354; x=1788363154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bVyuZZ5biJvVEoL5OzeeKXfWr7aXMe9k+lRMYGHpFns=;
        b=syu3YEgbbwf261qirRfpA6+MCGerVn6wRbklye5TSWy1I16TsPraRpxNznfc2wWwuN
         Q4SU6zBWyCJz6oo9IHx3HAlRAKfTf4gZ2PH9igEvcz3J8vw4yyfiC5Gb80SPipBt2Pw2
         fIQ+K6K+TSIejT6a8L2Da/WDtOG5vr48cCEbBBa7PpT1EK7gntg3EvHE83UA4GrHwWcM
         bKa3uo/BbBGgaaSQyZU+Kov4NbBoRurHkpdDtyENSGwH6z+SHyroir4Bd1Itt7gZBq4m
         z40V1ISMhuqYKWqkwfPcwfiguILmmfM/tGK82uW1TdcY7vsUHOI4OJnUWeYpi4/RF0PE
         lvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758354; x=1788363154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bVyuZZ5biJvVEoL5OzeeKXfWr7aXMe9k+lRMYGHpFns=;
        b=aUeJKHYCgFw9oalYhB7wX7bi4wTJ0UPD8ej03AF+d9WgFb1OopAHtrGpxDvrzAkRSP
         FN7He+hN4bx/vau+v44qG8/p3vf07f9Ulv/0ja0ap0pZRgpzYJaJ9jtemEbvMn+5Tb2M
         4UGg4Z5kb5d8GkizFXrsgbr09G/q8M3DBk8oQ1puS2bS1lGErQVS3VOxnNcGgbwzEl8U
         ADzjv4FTegFHTgrAfTFPj6eALfxLkf+XNaZdjLDtJbD25038nxoJLZdizGjq6ac83XYt
         4iaR53sI0/jyP/R4ze7FI8nn3wGJWkOaWPb8SAOpeyQjPXA2+IUsuTSyD8ki+51sP9nN
         btRg==
X-Forwarded-Encrypted: i=1; AHgh+RrDn3qPLjO8Es+uP8P8X4HskCcSWY3NRSOnD0kVmQ3Smy9LnQxLY5wmQDTH8kAOUh0NQK0Ituc=@vger.kernel.org
X-Gm-Message-State: AFuF++lx0Q9wvpOSCGR0VM+eMgyx6muehn14CEOqG66WXTL5XmCP5wQC
	DnxjhHp5YyNwjaZuj+r6M5fkUDe/7k7TZekJEoK4kyHNU39r27/Q3YL7eSWxJaEsQ8CFM5BlsUA
	7U3ZaXeQcE9Io2PO9D2dA/AjXtIOKqAv1NDuNIQkI
X-Gm-Gg: AR+sD12399sduNFSQICShq7fZOM0b9/jGUC74+qhQ1C3aajOvuGZzdHEGo95I7rG+9H
	kM4n/FqFqeJkj4QZZsp2BvDDuB1T3EjzyuFa1TeRBOJyDBqzJNY3OgArTEp9CNFUbElvJhuGh6D
	gx2mnlH+mn5RW0PpuuiJ9teJMyslRYYYybAamlpnyBInSprYy684FpP/8ZvboIH8ptQntGGP2vq
	Pp2O2J/Oku4PiV2C0xUJ6BvzThTlQw5Y2FqtrPwPdBqGq3RfH/W9BAK8UiD0ztkF2pYClZ2OHCS
	wG2I2VktyTSVnTgcsZsK4Dq+pLYdDcp7vtgZZYL364mVl4ZZooNk4lJ0i8b1F4DTV0cV1RE+9LQ
	l+g1XWZDIpvu3xuSq7GXKXTi/2/8BrmOp4zjhxzBd8KGAMhdT5WuYbpC/Jzo=
X-Received: by 2002:ac8:5cc8:0:b0:528:3216:b802 with SMTP id
 d75a77b69052e-52e42284f38mr86921071cf.15.1787758353467; Wed, 26 Aug 2026
 08:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826143339.271935-1-victor@mojatatu.com>
In-Reply-To: <20260826143339.271935-1-victor@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 17:32:22 +0200
X-Gm-Features: AcwNN1XGYz0PN3NDd3vGdCDFividvpP03QloIVQasH2Vojb2Mc2-xEf2XOpOZJA
Message-ID: <CANn89iKXhdimW-CXeMqextSCduR4iNcR31fuJzqA-WKSyLvOqw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: sch_htb: limit htb_classify inner-class
 filter hops
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:33=E2=80=AFPM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> From: Jamal Hadi Salim <jhs@mojatatu.com>
>
> htb_classify() follows each filter-selected inner class by switching
> to cl->filter_list, but never bounds the number of hops. A filter on
> an inner class can point back to itself or to another inner class that
> points back, creating an infinite loop in the packet classification
> path with the qdisc lock held and BH disabled =E2=80=94 a soft lockup / p=
anic
> from a single packet.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Note that a one-time warning (in the spirit of commit e82181de5ef4648
"pkt_sched: sch_htb: Warn on too many events.") could have been chosen.

Thanks.
