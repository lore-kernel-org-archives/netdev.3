Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323972;
	b=H6+stTaFPjCzT57EVcquWXCCxr6AVaQUyHzFNBFZ+TSjkWx1aGYYquj0G6DfQdgFlfdW
	 Ufe4DuMDM5WIwZpLH70aKPHqS4riNcBNXCPZlBwIrktvafAntyYXbEd74VxQarf7rXziE
	 ff94NHHU0Vul/4KQ5513jtxrGoUPun3044jfOQaD15J+fmErr2zwlsdrqKkzNaWqTO41+
	 iTYuQhEQylE82DWn6bz+OwNdPrhZ/oh1o64PqqyzgFP6zERtNzoOld1Xzleqq5P4d8xZS
	 vGI4ohekDE13xFXiph750rgwaLfrwLclnVvnb17LPxwvgHgQYa5YQjSpLA+d6ep/L9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pAB7/fvVZ95YxomLelu+IUsi/7sQRWLNuwSNWCsfc7A=;
	b=WXCfnOxHpys1FAvSIUhEMl1lRyjPOI1+D3Vlr7NFoPFWMz0AfHkSQPSmDuTdb1sNTQvm
	 TOsDhYYw0Atq9nby3ZZaqpVEz00BuCmDMUh1ckrGOCQ9GFWlyTq3jMAJZDFQ91cd4pg7C
	 ickRsyzkROIWEnSb7UAF8jBpqFj0lf64G8pStLHyAJdVdiRMUtQQ0BaS6IkCyvodncZQW
	 b0Ab0zZnsPMR5jWmdFcE7VCx0GmS9N9G3ozFQiz3WaK5fc7u4vNpt5gmLGaIfyybFX1sx
	 JKXwV2SZ5UeZgZnnvFvhfybnJ5mZKmVBQ97tpPe0hP3pPG3aRMa0KO25lrn5yhm76qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HlICEDVX;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48604606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48604606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HlICEDVX
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9d1114320so16952885ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794323971; x=1794928771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pAB7/fvVZ95YxomLelu+IUsi/7sQRWLNuwSNWCsfc7A=;
        b=HlICEDVXxHfK5otqLwk8U8Wunu2XWClI0Q0ReeNvl7DBjdgB+Dn5hxhOdJejFHfZZj
         NXblgliU9kDcQn1NEzBtX3IBbISmDuTZYrSEnJA2+2LNzT6IINBDJ/IhGTG7TYUrp3+a
         u6WRO2QUIXr3sSNUllom3ctI5W/nEekOiYfLQ5gYjJGEQFTxAiAUwmjSfZX7ixz/FMyd
         VsYRHyLLWrsihY6Fnvowk59pjNRZUt1pHiOlg6D1DKYiK/YeHBmsUukHvygq/hy2N42g
         2i+HVx2tfZRYaqjH1tTBptkcsV/2bS9ta4Vi28ZaYefaKTZ6jlDYQT+rH23pz/SAyga+
         CYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323971; x=1794928771;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pAB7/fvVZ95YxomLelu+IUsi/7sQRWLNuwSNWCsfc7A=;
        b=I4VA/950mLhPy6C1j+XYLydjbnbJEY8CZfS0GXll2CNnnWBcCgKuGx+hZMeJPKb/fh
         YUHX5ErrZPQUKZkFzjzQFUPS6YmY1m1p1FIynaAuBt+O2UvVMm/DwtRnMkolDdRmIcCv
         GIkBeS5ehK2uVm/d2phohbSAmSV4dshDFV+OqQunLrQsNX7r5moyZDZuuido1mtarrNV
         0EW5v67sw+hooZKVyHonNKkySbLhNRiCRvtHfNMODYAYRB0cts+CbQ6bCgb4APe0oN6o
         X9Bv9daCoX+gzrrvdx1hX7GaJn/z2TuOYSHbizvmatPcFnGRfFhpvroMMdKrgjNbGd2G
         eNJQ==
X-Gm-Message-State: APuU4Z9aVoALzHP9i48XNvYNAxNLl7D+IHjaX1MCd3AOEPl+1qFfcuc8
	43GFLh6goKNxzoni8jF/DayUQlZLjkG778LWjgx9hlf0rCyHow15r3LdRvZypkS62wY=
X-Gm-Gg: AYBFou20VI/QK7lGMofwC0CYnhQlAEJ31XusU32x0M3IarEayZsHWzqlTzbNw8SGXz+
	SiZ+PMSZeBLuidsSE6gWCbgJwlZqcR7Sm6PWCktHrMLWEHhv4NTA/YUu2yphZgxSX7tazkwWXrd
	nFJw25db71Ib5GNxq0yun9yqVYKVBhbgrtzMHPKwGbxgMHS+nkrsJyAH8TE9yCZrO4oKwA16ItB
	FAdY0QMyrLwXIxEd73O3jCyD9UTVInqanekybFyBnnZ/EMgoEeL32ebKGSOUmR9txC5yg9xbwoQ
	L4Bv3V/ChKX0r4mczvCk3NI8sihvKSguegOvOKR6FZTQEOAjBCS2c5ItH7jMJjaNepOn7cYJnCL
	adHkQ7rS+wNmWCCw7dM+vj+92BMKQ3E0USc28ObRGbjZinY4/lGb0rkljuqgov8mE8JeJvuCo0o
	RR6O6HuxoflmImnACrUOngDJr5hN6PY1jCmppNolz0WC2FRKPQ+1F9dWvPDfCqpAdgmnl4tQtGT
	Kmus0d4nRGp6js3rLWsqgYyuuxynZPX3CA8G7VLM1PxwmOMEzcnc6255jFRekzNrAiyuL1o/8vQ
	S+CfImi6gOSSdXRuXHmIVtbc/T/QE0bEt8EehaAmhdS1UvJj/Wpc86qTyeu96nrLNNM0h88=
X-Received: by 2002:a17:903:228e:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2edb912b301mr29703235ad.14.1794323971526;
        Tue, 10 Nov 2026 07:19:31 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d906e4sm10414035ad.40.2026.11.10.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:19:31 -0800 (PST)
Date: Tue, 10 Nov 2026 07:19:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel
 <idosch@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>, Andrea Parri
 <parri.andrea@gmail.com>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Willem de Bruijn
 <willemb@google.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rtnetlink: return EMSGSIZE when first dump entry
 does not fit
Message-ID: <20261110071928.6e8aebd7@phoenix.local>
In-Reply-To: <avLVfWQEtsLH4BUA@fedora>
References: <20261109012115.11898-1-stephen@networkplumber.org>
	<20261109012115.11898-2-stephen@networkplumber.org>
	<avLVfWQEtsLH4BUA@fedora>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 16:27:41 +0800
Hangbin Liu <hangbin.liu@linux.dev> wrote:

> Hi Stephen,
> On Sun, Nov 08, 2026 at 05:13:12PM -0800, Stephen Hemminger wrote:
> > If a route entry is too large for the dump skb, the dump is silently
> > truncated and no error is returned.
> > 
> > For handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE, rtnl_dumpit() drops
> > -EMSGSIZE and returns skb->len. With an empty skb this is 0, so the
> > dump ends with NLMSG_DONE and status 0, and the remaining entries are
> > lost.
> > 
> > The first dump skb is allocated from __netlink_dump_start() while
> > max_recvmsg_len is still 0, so it is only NLMSG_GOODSIZE. On a 4K page
> > kernel that is under 4000 bytes, and a 500 way multipath route does not
> > fit:
> > 
> >   ip link add dummy0 type dummy
> >   ip link set dummy0 up
> >   ip route add 198.51.100.0/24 table 100 \
> > 	$(for i in $(seq 500); do echo -n "nexthop dev dummy0 "; done)
> >   ip route show table 100
> > 
> > The dump prints nothing and exits 0, although "ip route get
> > 198.51.100.1 table 100" still shows the route.
> 
> One question. AFAIK, `ip route get` doesn't support "table" parameter. No?
> 
> Thanks
> Hangbin

Your right AI is wrong in the commit message.
A way to use get is to add a rule.

#   ip rule add to 198.51.100.0/24 lookup 100
#   ip route get 198.51.100.1
198.51.100.1 dev dummy0 table 100 src 192.168.50.131 uid 0 
    cache 

But best to just drop the incorrect wording there.
