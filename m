Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65E331203
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976406; cv=pass; b=pfnUwMoKTVxhHKYiqG3OGsgoQlF2Pc1ZX/8+jOMGkyZs8UssqJ5ckfxLw+CEoszs3YYS60l6VZ0ySNG4HU5slWrbOLZh0pSEWsr1O4JIlW2LrMqZ//sL/25lFOEX797IZUrcGcx/+Yuif2TM28LEyUmLzaI5zXAMliVBaQTxtrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976406; c=relaxed/simple;
	bh=uANa5NwbAb/2GTzRUBPYoq3qdbRtCfUTczVJ6n0p8xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puEBqjfrM6h9vsKwCpejRCW5aQjcmGeRd+SrHUciZYneKLJuI7OYki8o3/jo3I78Ku/jhOows/lK81qbKwBXAXvXfAzf9qtcO4faqDKC6g7MZle2McKv7OSeFxj3j/RcVf1MdG1/ZuuolaqmheLbXDtk0aMTXlagUVeoljwVHo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bZLR8pIF; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bZLR8pIF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848d21bbaffso1322741b3a.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 03:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784976404; cv=none;
        d=google.com; s=arc-20260327;
        b=b1ovwsxBtmQ/f6THrrj248duJyfNvecDytgFxrIbRglkjEAhfTL6yZLGWZVWt//6yY
         h4D+t8uskIrC6oRzV6Xbw2FXwSB9vXjvEbkt7r/N3kuhaG48ogL+79PEWY/XBWKcXHNt
         l+gnlRCYiZy4YkWC09T8ZqcPB4ioGbUZWlle+Ed1jd9mPh6DHjJEuXb9NSzaTgTafFjE
         Qmaa/0kAnO36/f9jjB/YOMdQW6vZOTWhb3CZ4++zPRqUFBDEMrip7Z/zDvm/74GlD8Ky
         1JODjdhVbcIdb93eFOGgo1ilX3L3T6VYzWZCcEoBZotUNkc/dqdxhx2m3QaQUE/x9/ZK
         V6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uANa5NwbAb/2GTzRUBPYoq3qdbRtCfUTczVJ6n0p8xw=;
        fh=kDYCIY48lOO3Y9DSQQY5cInP+RUciqK4mMvVup+9WZ0=;
        b=QkkUhNNd/i9HYsyACFIqjNTXfDzNXwwWw7egbuWR7FUy3FngrjkF9h/0a6uPZyncw/
         bceDoyvd7Cku6cVcImqKOJHQmSBVyIJt262pwSgoix9WJHit4hNJ7OcmVUGVhXbNeoIk
         kfwRNAygEfV3UFCFx9z47Vw5N/INMxJifauZdagieYt3nGKkLRYmnoqnX66kaUS86Bz2
         h4y7cA8SVfD9mv+V9RmTZRgYhO4TnTWlBhn5DdG1V/q1gfZ10hiBtAf9Z+gsqXzpSs6w
         XGikuknp0UdowIfQ4uk4c/wisqaiV4d1AZrB3Mml8OS5yTp+hW/RnlCI2ahz6E96qZot
         Jx3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1784976404; x=1785581204; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uANa5NwbAb/2GTzRUBPYoq3qdbRtCfUTczVJ6n0p8xw=;
        b=bZLR8pIFNp38vyTbXiU65XsMzGbAw4O/Ck4Kt90hlOEUmmLuPtnRHvyfd2LaxzrYq8
         5WgHzXpH+5O8hZCgf9B6S3J7+zKwLov6yeY8psd1dx8z8uC5ta5KqLgVExfQiV5oWJYh
         MLTEr30zn65tNvCyeyBYDjY4sy9aFIUlDfBuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784976404; x=1785581204;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uANa5NwbAb/2GTzRUBPYoq3qdbRtCfUTczVJ6n0p8xw=;
        b=mWcgvvfkEiQnlB4RIPmDSzCU0nMMz6ggRfeG2pS798CebFtayUKC5HPjOUCqNMVP2u
         GyBiYlCvIKh80XWs75nAS22TjhOZuUXSDPAuUfPmrW2B3rnQbW/rNYLwT3V722f+bYT1
         xvwdE7vsNWEAdv/hr8DokewYsIr2izIVvUVKlCRl7RvFkQ6Iszrbx3JgJ3OEu5lnnCLN
         Xn1+/64l8Yhf6nj/xL6WJjjHb49wtrSSyDHJgF4J8t+5rPq0IMLbSHebbZefHDKxsblD
         DnP1ZXlXOK1IzImX0MPLypAO+B4HTH4YpvMBYA1zVa0+fkAp3uRN88J61kEXC3gcXxOC
         dnNw==
X-Gm-Message-State: AOJu0YwXULuqRb+NPxsSYLpAf6NK/TC7iQgfTn9JSBEodNDU5JewR0Dt
	MgXCGV4pz4813LCV+1ZaEb6J9qQA5I2SAAL0DkbDMW1Tg9dwccB+MaRS1dIyfH8YsNBixM99v8C
	L2IoYii3xXumG2KLkEx1TGMgXM1b1LKvRDotBg16x
X-Gm-Gg: AR+sD13gqGZ0LjMWO5IsVYHhEfCZvRv14GA/aMHIjI4+2ge+O/Q6JQ+eP3ZMLQ2Zys1
	4klbQHST9ouXAvoHQ9JHGGck2kCQd66uXlYaPQ3LdRecHh/qY729B+qKQdoGDBn4DmOUU23GQIj
	BMcBjRvEYIAfwNWutVs97dGU09UNvdF/u+zUehr6GNKBTRFcXOzc3tPcJJAieTyVXiX+TFRj2ka
	NjToPtxF6Y5T5eCAWteOCl5cc+C8XEA4/fmThtbjqPKieiq3VMggEUxcYFfzss=
X-Received: by 2002:a05:6a00:340f:b0:848:4d1a:9556 with SMTP id
 d2e1a72fcca58-84e593ff3e5mr1411632b3a.11.1784976404014; Sat, 25 Jul 2026
 03:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784709375.git.bronzed_45_vested@icloud.com>
In-Reply-To: <cover.1784709375.git.bronzed_45_vested@icloud.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 25 Jul 2026 06:46:32 -0400
X-Gm-Features: AUfX_mwn_wTC9d3_u2bXlM8Oo-WJ8ZmR7U3SHSMAUG5CwnnhjuheH5tEPQtCxDk
Message-ID: <CAM0EoMm8HGCcmGB5btFfWKA7-7sGQyhYB_FvxQu7POhZ+W=dsw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net/sched: act_vlan: pop_eth can strip
 non-Ethernet skbs and panic loopback
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, gnault@redhat.com, 
	vega@nebusec.ai, bronzed_45_vested@icloud.com
Content-Type: multipart/mixed; boundary="0000000000007e8e9c06576d3422"

--0000000000007e8e9c06576d3422
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 1:54=E2=80=AFPM Ren Wei <enjou1224z@gmail.com> wrot=
e:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> Hi Linux kernel maintainers,
>
> We found an issue in net/sched/act_vlan.c.
> The bug is reachable by an unprivileged user using private user and netwo=
rk namespaces.
> The relevant details are provided below.
>

Please remove bouncing @bytedance emails from the CC list.

You did not address the discussion we had earlier, which is a very
good example of an issue Yuan brought up at the bof - "fixing the root
cause".
Attaching the last email from Guillaume since this was not on a public list=
.
I had argued you only need patch 2 (and to be safe handle both pop and
push) and Guillaume argued that would not fix the root cause and there
is potential the bug could still happen and patch 1 would be needed.
His exact wording is:
"
So, if patch 1 isn't needed, that means we must guarantee all skbs
reaching an ARPHRD_ETHER device to have at least ETH_HLEN bytes of
headroom.
"
after some back and forth we steered into drivers and pskb_may_pull()
invocation.

In any case it would be a good idea for you to review and consider the
discussion and infact test with suggested vrf device (which doesnt
pskb_may_pull())

cheers,
jamal

--0000000000007e8e9c06576d3422
Content-Type: application/octet-stream; name="vlan.email"
Content-Disposition: attachment; filename="vlan.email"
Content-Transfer-Encoding: base64
Content-ID: <f_ms081apo0>
X-Attachment-Id: f_ms081apo0

RGF0ZTogRnJpLCAzIEp1bCAyMDI2IDE3OjU0OjE3ICswMjAwDQpGcm9tOiBHdWlsbGF1bWUgTmF1
bHQgPGduYXVsdEByZWRoYXQuY29tPg0KVG86IEphbWFsIEhhZGkgU2FsaW0gPGpoc0Btb2phdGF0
dS5jb20+DQpDYzogUmVuIFdlaSA8bjA1ZWNAbHp1LmVkdS5jbj4sIGppcmlAcmVzbnVsbGkudXMs
IGRhdmVtQGRhdmVtbG9mdC5uZXQsDQoJZWR1bWF6ZXRAZ29vZ2xlLmNvbSwgcGFiZW5pQHJlZGhh
dC5jb20sIGhvcm1zQGtlcm5lbC5vcmcsDQoJY29uZy53YW5nQGJ5dGVkYW5jZS5jb20sIHBlaWxp
bi55ZUBieXRlZGFuY2UuY29tLA0KCXl1YW50YW4wOThAZ21haWwuY29tLCB5aWZhbnd1Y3NAZ21h
aWwuY29tLCB0b21hcHVmY2tnbWxAZ21haWwuY29tLA0KCXpjbGlhbmdjbkBnbWFpbC5jb20sIGJp
cmRAbHp1LmVkdS5jbiwgYnJvbnplZF80NV92ZXN0ZWRAaWNsb3VkLmNvbQ0KU3ViamVjdDogUmU6
IFtQQVRDSCBuZXQgMC8yXSBuZXQvc2NoZWQ6IGFjdF92bGFuOiBwb3BfZXRoIGNhbiBzdHJpcA0K
IG5vbi1FdGhlcm5ldCBza2JzIGFuZCBwYW5pYyBsb29wYmFjaw0KTWVzc2FnZS1JRDogPGFrZmJL
YUdCUmlLRzNQMzNAZGViaWFuPg0KDQpPbiBXZWQsIEp1bCAwMSwgMjAyNiBhdCAxMjoxMzo1M1BN
IC0wNDAwLCBKYW1hbCBIYWRpIFNhbGltIHdyb3RlOg0KPiBIaSBHdWlsbGF1bWUsDQo+IA0KPiBP
biBUdWUsIEp1biAzMCwgMjAyNiBhdCAxMDoyOOKAr0FNIEd1aWxsYXVtZSBOYXVsdCA8Z25hdWx0
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBKdW4gMjksIDIwMjYgYXQgMDY6
MzE6NDZQTSAtMDQwMCwgSmFtYWwgSGFkaSBTYWxpbSB3cm90ZToNCj4gPiA+IE9uIFN1biwgSnVu
IDI4LCAyMDI2IGF0IDEwOjQ24oCvUE0gUmVuIFdlaSA8bjA1ZWNAbHp1LmVkdS5jbj4gd3JvdGU6
DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IFd5YXR0IEZlbmcgPGJyb256ZWRfNDVfdmVzdGVkQGlj
bG91ZC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IEhpIExpbnV4IGtlcm5lbCBtYWludGFpbmVycywN
Cj4gPiA+ID4NCj4gPiA+ID4gV2UgZm91bmQgYW4gaXNzdWUgaW4gbmV0L3NjaGVkL2FjdF92bGFu
LmMuDQo+ID4gPiA+IFRoZSBidWcgaXMgcmVhY2hhYmxlIGJ5IGFuIHVucHJpdmlsZWdlZCB1c2Vy
IHVzaW5nIHByaXZhdGUgdXNlciBhbmQgbmV0d29yayBuYW1lc3BhY2VzLg0KPiA+ID4gPiBUaGUg
cmVsZXZhbnQgZGV0YWlscyBhcmUgcHJvdmlkZWQgYmVsb3cuDQo+ID4gPiA+DQo+ID4gPiA+IC0t
LS0gZGV0YWlscyBiZWxvdyAtLS0tDQo+ID4gPiA+DQo+ID4gPiA+IEJ1ZyBkZXRhaWxzOg0KPiA+
ID4gPg0KPiA+ID4gPiBUaGUgYnVnIGlzIGluIGB0Y2Zfdmxhbl9hY3QoKWAgd2hlbiBoYW5kbGlu
ZyBgVENBX1ZMQU5fQUNUX1BPUF9FVEhgLg0KPiA+ID4gPiBUaGUgYWN0aW9uIGlzIGFwcGxpZWQg
d2l0aG91dCBjaGVja2luZyB0aGF0IHRoZSBza2IgaXMgb24gYW4gRXRoZXJuZXQNCj4gPiA+ID4g
ZGV2aWNlLiBPbiBsb29wYmFjayBhbmQgb3RoZXIgbm9uLUV0aGVybmV0IGRldmljZXMsIGBza2Jf
ZXRoX3BvcCgpYA0KPiA+ID4gPiByZW1vdmVzIGBFVEhfSExFTmAgYnl0ZXMgZnJvbSB0aGUgc2ti
IGhlYWQgZXZlbiB0aG91Z2ggdGhlIGxhdGVyIFRYIHBhdGgNCj4gPiA+ID4gc3RpbGwgZXhwZWN0
cyBhbiBFdGhlcm5ldCBoZWFkZXIuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSSBkb250IHRoaW5r
IHlvdSBuZWVkIHBhdGNoIDEuDQo+ID4gPiBza2Jtb2QgYWxyZWFkeSBjaGVja3MgYXQgYWN0X3Nr
Ym1vZC5jOjYwICBhIG5vLW9wIG9uIG5vbi1FdGhlcm5ldA0KPiA+ID4gZGV2aWNlcyBsaWtlIGxv
Og0KPiA+ID4gLi4NCj4gPiA+ICAgICAgfSBlbHNlIGlmICghc2tiLT5kZXYgfHwgc2tiLT5kZXYt
PnR5cGUgIT0gQVJQSFJEX0VUSEVSKSB7DQo+ID4gPiAgICAgICAgICBnb3RvIG91dDsNCj4gPiA+
ICAgICAgfQ0KPiA+ID4gLi4NCj4gPg0KPiA+IExvb2tzIGxpa2UgcGF0Y2ggMSBtaWdodCBmaXgg
YSByZWFsIHByb2JsZW0sIGFsdGhvdWdoIG5vdCB0aGUgb25lDQo+ID4gZGVzY3JpYmVkIGluIHRo
ZSBjb3ZlciBsZXR0ZXIuDQo+ID4NCj4gPiBUaGUgbm9uLVNLQk1PRF9GX0VDTiBjYXNlcyByZXF1
aXJlIHVwIHRvIEVUSF9ITEVOIGJ5dGVzIG9mIHdyaXRhYmxlDQo+ID4gaGVhZHJvb20uIEhvd2V2
ZXIgdGhlIHNrYl9lbnN1cmVfd3JpdGFibGUoc2tiLCBtYXhfZWRpdF9sZW4pIGNhbGwNCj4gPiBj
dXJyZW50bHkgZG9lc24ndCBnaXZlIGFueSBzdWNoIGd1YXJhbnRlZSAobWF4X2VkaXRfbGVuIGlz
IHNldCB3aXRoDQo+ID4gc2tiX21hY19oZWFkZXJfbGVuKHNrYiksIHdoaWNoIG1pZ2h0IHJldHVy
biAwIGFzIHNob3duIGluIHRoZQ0KPiA+IHJlcHJvZHVjZXIpLg0KPiA+DQo+ID4gU28sIGlmIHBh
dGNoIDEgaXNuJ3QgbmVlZGVkLCB0aGF0IG1lYW5zIHdlIG11c3QgZ3VhcmFudGVlIGFsbCBza2Jz
DQo+ID4gcmVhY2hpbmcgYW4gQVJQSFJEX0VUSEVSIGRldmljZSB0byBoYXZlIGF0IGxlYXN0IEVU
SF9ITEVOIGJ5dGVzIG9mDQo+ID4gaGVhZHJvb20uDQo+ID4NCj4gDQo+IEkgcmUtcnVuIHRoZSBw
b2Mgd2l0aCB2ZXRoIHdoaWNoIEFSUEhSRF9FVEhFUiBhbmQgbm90aGluZyBoYXBwZW5lZCAtDQo+
IGNlcnRhaW5seSBubyByZXBvcnQgZnJvbSBLQVNBTi4NCj4gU29tZXRoaW5nIGxpa2U6DQo+IA0K
PiBpcCBsaW5rIGFkZCB2ZXRoMCB0eXBlIHZldGggcGVlciBuYW1lIHZldGgxDQo+IGlwIGxpbmsg
c2V0IHZldGgwIG10dSAxNjMzNCAgIChvciA2NTUzNSkNCj4gdGMgZmlsdGVyIGFkZCBkZXYgdmV0
aDAgZWdyZXNzIC4uLiBhY3Rpb24gdmxhbiBwb3BfZXRoIGFjdGlvbiBza2Jtb2QgZG1hYyAuLi4N
Cj4gDQo+IEkgdGhpbmsgdGhvdWdoIChuZWVkIHRvIGxvb2sgY2xvc2VyKSB5b3VyIGNvbnRlbnRp
b24gdGhhdA0KPiBza2JfZW5zdXJlX3dyaXRhYmxlIGlzIGNvcnJlY3QuIEkgZG9udCBoYXZlIHRp
bWUgdG8gcHJvdmUgaXQgcmlnaHQgbm93DQo+IGJ1dCBsaWtlbHkgaXQgZG9lc250IGZhaWwgYmVj
YXVzZSBtYXkgYmUgb3ZlcndyaXR0ZW4gYnkgcHNrYl9tYXlfcHVsbA0KPiBpbiB2ZXRoX3htaXQo
KSwgc28gaXQgd29ya3Mgb3V0IGp1c3QgZmluZT8NCg0KWWVzLCB2ZXRoIGVuc3VyZXMgaXQgaGFz
IGVub3VnaCBoZWFkcm9vbSwgc28gdGhlIHByb2JsZW0gY2Fubm90IGhhcHBlbg0Kd2l0aCB0aGlz
IGRyaXZlci4NCg0KPiA+ID4gUGF0Y2ggMiBzZWVtcyB0byBmaXggdGhlIHJvb3QgY2F1c2UsIGRv
ZXNuJ3QgaXQ/IEJ1dCBldmVuIHRoYXQgY291bGQNCj4gPiA+IGJlIHNpbXBsZSBleGFtcGxlLCBu
b3QgY29tcGlsZSBvciB0ZXN0ZWQgYXMgYXR0YWNoZWQuLg0KPiA+DQo+ID4gSXQganVzdCBwcmV2
ZW50cyB0aGUgcHJvYmxlbSBmcm9tIGhhcHBlbmluZyBvbiBsb29wYmFjayBhbmQgbm9uLUV0aGVy
bmV0DQo+ID4gZGV2aWNlcy4gQnV0IHdoYXQgYWJvdXQgYWxsIHRoZSBBUlBIUkRfRVRIRVIgZHJp
dmVycz8NCj4gPg0KPiA+IElmIHdlIGNvbnNpZGVyIHRoYXQgdGhlIHN0YWNrIG11c3QgZ3VhcmFu
dGVlIHNrYnMgdG8gaGF2ZSBFVEhfSExFTiBieXRlcw0KPiA+IG9mIGhlYWRyb29tIG9uIEFSUEhS
RF9FVEhFUiBkZXZpY2VzLCB0aGVuIHBhdGNoIDIgZG9lc24ndCBmaXggdGhlDQo+ID4gcHJvYmxl
bSAod2UgY2FuIGp1c3QgY2hhbmdlIHRoZSByZXByb2R1Y2VyIGFuZCByZXBsYWNlICJsbyIgd2l0
aCBhbg0KPiA+IEV0aGVybmV0IGRldmljZSB0aGF0IGFzc3VtZXMgRVRIX0hMRU4gb2YgaGVhZHJv
b20pLg0KPiA+DQo+ID4gSWYsIG9uIHRoZSBvdGhlciBoYW5kLCB3ZSBjb25zaWRlciB0aGF0IG5v
IGFzc3VtcHRpb24gY2FuIGJlIG1hZGUgb24NCj4gPiBza2IncyBoZWFkcm9vbSwgdGhlbiB3ZSBu
ZWVkIHRvIGNoZWNrIHRoYXQgYXQgdGhlIGJlZ2lubmluZyBvZg0KPiA+IGxvb3BiYWNrX3htaXQo
KSAoYW5kIHBvdGVudGlhbGx5IG90aGVyIGRyaXZlcnMpLg0KPiANCj4gU2VlIG15IGNvbW1lbnQg
b24gdmV0aCBhYm92ZS4gQ29tbWVudCBvbiB3aGF0IHlvdSBhcmUgc2F5aW5nIGhlcmU6DQo+IERv
aW5nIGEgZ3JlcCBvbiBjYWxsZXJzIG9mIGV0aF90eXBlX3RyYW5zIHdobyB1c2UgaXQgb24gdHgg
cGF0aCBzaG93cw0KPiBvbmx5IGxvb3BiYWNrIGFuZCB2cmYgZG9udCBkbyBhIHBza2JfbWF5X3B1
bGwoKSBiZWZvcmUgaW52b2tpbmcgaXQuDQo+IHZyZiBpcyBBUlBIRFJfRVRIRVIsIHNvIHdoYXQg
eW91IGFyZSBkZXNjcmliaW5nIG1pZ2h0IGJlIHBvc3NpYmxlIHdpdGgNCj4gVlJGIChJIHdvdWxk
IGNvbnNpZGVyIHRoYXQgYSBWUkYgYnVnIHRob3VnaCkuDQo+IFBlcmhhcHMgdGhlIE9QIGNhbiB0
ZXN0IHdpdGggVlJGIGFzIHdlbGwuLg0KDQpJIGFsc28gdGhpbmsgaXQnZCBiZSBzYWZlciBmb3Ig
dnJmIHRvIHZlcmlmeSB0aGUgaGVhZHJvb20gb2YgaXRzIHNrYnMsDQppZiBpdCBkb2Vzbid0IGFs
cmVhZHkuIE90aGVyIHZpcnR1YWwgZHJpdmVycyBnZW5lcmFsbHkgZG8gdGhhdC4gSSdtIG5vdA0K
c28gc3VyZSBhYm91dCBwaHlzaWNhbCBkcml2ZXJzLiBJZiB0aGV5IGRvbid0LCB0aGVuIGxpbWl0
dGluZw0KVENBX1ZMQU5fQUNUX1BPUF9FVEggdG8gQVJQSFJEX0VUSEVSIGRldmljZXMgd291bGRu
J3QgZml4IHRoZSBwcm9ibGVtLg0KQW5kIGV2ZW4gaWYgd2UgYWRkZWQgc3VjaCBsaW1pdGF0aW9u
LCBJIGRvbid0IHNlZSB3aGF0IHdvdWxkDQpwcmV2ZW50IGEgdXNlciBmcm9tIGNvbmZpZ3VyaW5n
IFRDQV9WTEFOX0FDVF9QT1BfRVRIIG9uIGFuIEV0aGVybmV0DQpkZXZpY2UgYW5kIHJlZGlyZWN0
IHRoZSByZXN1bHRpbmcgc2tiIHdpdGggbm8gaGVhZHJvb20gdG8gdGhlIGxvb3BiYWNrLg0KDQpC
eSB0aGUgd2F5LCBJJ20gZ29pbmcgdG8gYmUgb2ZmbGluZSBmb3IgYSBiaXQgbW9yZSB0aGFuIGEg
d2Vlay4gU28NCnNvcnJ5IGluIGFkdmFuY2UgZm9yIHRoZSBkZWxheSBpbiBteSBmdXR1cmUgcmVz
cG9uc2VzLg0KDQo+IGNoZWVycywNCj4gamFtYWwNCj4gDQoNCg==
--0000000000007e8e9c06576d3422--
