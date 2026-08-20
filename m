Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A94779BE
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244311; cv=pass; b=pvmR3ydwPO7rsx1n9rA1Np0wZK5xqNQdSJWrsXvIIayY7C6RfF0TR3M5hxUbuW1vXormdrV1vHmfEaL0yZPQ4rXq7bkdHhCUbCjIBF8uLzx5bzjQ2GWHKtHXqIQzw1jqFaOWMzoUwlSAj+F9WjzRoHUnEsZ85NOYemHblxHbaRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244311; c=relaxed/simple;
	bh=BNOMAzPUdvkUS122he51inruQZpuv9iqD6W+xOwXSCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rovYz9gNK11z73pLNPoswFqnsl82oZAVzrUTwyALZW400o6h3KPYWkVCNTIOM6ObMthh80kIL+tcRMBRPMuWXxWGxukeS5sADMxnZo5Q3z6YSw4mLoQ/czY14aG7KTpshqJAd/AR8hxYHhWmKrPGBEPeSzh+GZAHBGccXuKSiU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=JcvXW9k9; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="JcvXW9k9"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c20363107f4so2550666b.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787244307; cv=none;
        d=google.com; s=arc-20260327;
        b=HksOJk8SrdNcnS2KXUNTfMTOgbQKqTP9/0AcplPBTV06Go734DBWa4H9PqScpiLGGG
         lavm//QsD1Pt/bZkr6yuWLPVX2rGV0lubfTQdwz8iziHjvo9DvQO16cKLRXQt3F/9Kk6
         VjHqGkHfeJxdUhQ4IP3LzovEa1pJDyN4OOaQvREzsG+KoT62mrTWK6AJJVnFGrRZHoCa
         TIWGmWosLv+iFa6eM26l+sDOLWcgkoNkJv7HdtA5jJd+0KBk4Rr1bhv7MGKSLV5TwMFJ
         AJF0pGcY4gJ921mBTkYZzpDoTiEekMufS+5oYr8XdjXIWxC8AKlvF1g6/uHBm508OymF
         HuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BNOMAzPUdvkUS122he51inruQZpuv9iqD6W+xOwXSCk=;
        fh=gCHEg338lDzpoUdBuNkJ8nLn8puUktbw6sEgm/WN9TI=;
        b=rvZfolh/BKWNGqONM1R4PR5P2IvaxCUJkCUccq4iMBKzo+tIE690g/ouLu/9gOaqej
         v8T1TQZOX/tAE3Lx8MX1h+Jy+LdDhm7+tQ9bCqFeDlcEL/aHQcfwhNI0Z8pxzBB6a1W8
         f9wCS7PKCAGO1JVV+k/x2IvS4xTjzlrXSrsN0QKhuLdgvnMxdMhwSeGwxSQo4T9mNbrw
         COnt37R2fy34axxIHbjw1k/b8ft4irlsEuDzEiLyUpDP7RCPJZAaie74LoWS1/HFGaI2
         eOOCP1bnR/Yun9VBwQYKomFMHArouMbwqY66or1U1Y/TLyeISaBjrNv558cpQdJG2bhO
         xDjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1787244307; x=1787849107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BNOMAzPUdvkUS122he51inruQZpuv9iqD6W+xOwXSCk=;
        b=JcvXW9k9rm4x14pZqTobhtErymz/PFmjOM8RNnwt/e+57f7V9dI6AXV4vlKq1rqqZC
         cofTQufZKI/di3320PTpnxtH6Jmyqpj5y2BUzJMfKVJoFEVpk76qUJmenGXu6ZuuU4gw
         TQaqDrlbZnSToLGdRBl/cf5FHIIxHzJOzkk9LTBBQWxEvj63fYjsc84Stj+WsubbJ1M8
         LniZi6MTOL2Tve/1IKqWoOyMpP+LPMlUA4O1hWVj9Qx3XxFHX3dVmhQBlyg2ky1XLip7
         g+NL4H7uKqwm0hJuMMSBBLiD49ZacNUAFDJiWjnUv/wOsOCQQQBdsOMoNMDPR6CHAjys
         ZJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244307; x=1787849107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNOMAzPUdvkUS122he51inruQZpuv9iqD6W+xOwXSCk=;
        b=qHB2UiAacneGPnH/Ow4bR0tKdLjL+X7rvFRbxwp6SOREVraOxy6JM2wswxl7khMytD
         Cd4Nri9TfJTIykPjqZmkrrZDtskyr3UK4kv3UBJCG9R8aM2dzPNBt9aMkIPllce03cyJ
         ktZAoPTQAUwkmXdUOu6hgyDu3plrM3uQdegjHuflOnHfUkB8GVd81fu7Q4iox+4rE5w5
         l0wWSp20SXeGJqTes1iBNY7e6ZnqbIw73b6FyFaoa0VaLz+nIVMeh8Y4hPzw3JGL7POe
         ZPqTl+vMKcOgTB3IbhCED/1we0VbTmKBnj0y6Om2zi7llgV+iUHo5n+IAyYgIYP0ESd2
         8MOw==
X-Forwarded-Encrypted: i=1; AHgh+RoKzpE3enkquIJQ+sKMcqcDON9+0p25W4h20GtFoNYkqXP0JAmgLm/vgX2qhGc7eM8fBn9AGO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPzSAiVjx+ko35LWroeYTNVmCTCNOqMxzzc852sm5ORPLBnDBh
	PTfRwx74yngg8o2bUQDN+r7CWxJ9u6SbLVZBph1Osnht6nRGP5rkpPbCIMJNV3ffK0WKI81b8st
	rUCyl8wSUIbjr6me6I9+s20h6tJbbkZg1o5OIrIZMjA==
X-Gm-Gg: AR+sD12yHkhUPGmKJxswRGlpGV0SlVYAHCXAPvaIRagBI4YN8W6JKdnu2L0BNgBOmYt
	9UV7KWedy55RTtcaiwEI47Xnu3Dejx6D1ClVXO7f4pUloYpUHMr8R7DkuIIJWlJ2HXWo0BGtSPz
	gsiDrY1omUOykt/8tljrGMgFcm2vLHT/48Cox3LDlxCgvjEXt0tP/oFyvA0cWeG0G94+owG1BOf
	kxugREUAmQP6ToHU8o2IVRg6D4KjNNlL7aLL/F05G9J789MB665Oq/xya10Ac1LtQeoGn6qbqI4
	P3cH8YSoxbundyBuclyvBjdtCCIP0CFdC9K0c9f6xVrHwO45tWXpxvx9Tua982+3QMIvuE6bK90
	=
X-Received: by 2002:a17:907:3c8f:b0:c21:34a3:4df9 with SMTP id
 a640c23a62f3a-c23f92a86e6mr911409566b.3.1787244307611; Thu, 20 Aug 2026
 09:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625114216.2507435-1-louis.scalbert@6wind.com>
 <fc98de42-02cb-4de9-8986-b77414793df5@kernel.org> <CAJ5u_Od76V6cxcEUT4h4EQQ4opJk9tLYHYWum7tWp0t1CWjGZw@mail.gmail.com>
 <aoa-dJKd25fTARYm@fedora> <aobBDGBjg_TJeu9g@fedora>
In-Reply-To: <aobBDGBjg_TJeu9g@fedora>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Thu, 20 Aug 2026 18:44:56 +0200
X-Gm-Features: AcwNN1VMnlD9SkJ1QE3Xcv2tUj9o-_9yM-0rjqbx_MQGK43-S3X6PCodCj4gfV0
Message-ID: <CAJ5u_OfjH5eOcPuHgnz8F5RmqEOtx9JjC_xmQxg0xXfQPDjCcA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v5] ip/bond: add lacp_strict support
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, andrew+netdev@lunn.ch, jv@jvosburgh.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, 
	andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com, 
	jonas.gorski@gmail.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for notifying me about this issue.

I have just posted the v6.

regards,

Le jeu. 20 ao=C3=BBt 2026 =C3=A0 10:55, Hangbin Liu <hangbin.liu@linux.dev>=
 a =C3=A9crit :
>
> On Thu, Aug 20, 2026 at 04:44:45PM +0800, Hangbin Liu wrote:
> > Hi Louis,
> > On Thu, Aug 20, 2026 at 09:58:16AM +0200, Louis Scalbert wrote:
> > > Hello Matthieu,
> > >
> > > thank you for pinging.
> > >
> > > There is no version 6, and there are no comments regarding version 5.
> > >
> > > best regards
> >
> > I saw the patch status is archived. Would you able to re-post it?
> > I can help review it.
>
> BTW, I just took a glance at your v5 patch. Since you use `parse_on_off`,
> there is no need to define `lacp_strict_tbl` anymore.
>
> Thanks
> Hangbin
