Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08050331203
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227663; cv=pass; b=DoNJiUdaO+l5nxQr74DSFgSGBcnM/ehApBLyYQzuv2nSkkqbC2fMgSbtqqEYuCOhAhpT2YpKSw6iC4L2Pop22Rcorny+laCuOwRDnANxezQu/1AKm5mAvxn06ONapuwFyhPcCS9IRaZ7K9EOLDUGHgbDiAxNeA7dK280h0gdiCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227663; c=relaxed/simple;
	bh=aV0hpfIPJg5R8Lh2IDjZGOErZ14awD8uz5wwI/na59Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAeqf6OsGySoCvPDaOTzFhOUD8QVQPwh7G22dJnXbJPRevFnyXsG3WVZctl+4fSkVBxvTNjPfdg9sl82Ngp2c7c4V03ra9VWGcvBpVF60sm25PJy6hBF79wwHbPZXtWhw7/W2vsqsPR+XOG0cqp/ro5YjNIzWZQlQj/75khvimA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUvT0H1c; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUvT0H1c"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76bcb09so8084851cf.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789227661; cv=none;
        d=google.com; s=arc-20260327;
        b=M1uHN5PtJncECE2/wmyGx2Qqk09DS8rkNCnVOOFAKF5DpsW+nCEKO3YZUgBap6HEs5
         7wpNxtnSed8DhFnUsDQ0tqEp3w6XjKSlwpq4OS0vxDHkF4I3MoyFjgBVB7KI+p80nOfG
         KfNR21N0v3ScpSoTZs1vx1fPx7pLGnZ3TnPtji75E3qf8XOlErQyrzwqgsr639XGRjCB
         pwYHSmKhUAj/pVJEXHLMuyR1J3xC4Q3E7LzjZ//GA3OISTWIQo0ijkOcFD7LFFMHYV4g
         GeYNOVMTmjf9sz2FlTTHS5HeNe4L7z2UshV02WutuwCmy1L58C0gognvdvCohtsmF2Ga
         QfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aV0hpfIPJg5R8Lh2IDjZGOErZ14awD8uz5wwI/na59Q=;
        fh=GcI5aTZ8PG5yKfqlowEll453rSCHN9WB5LzbPgEr9y0=;
        b=EDfMzvqCtfoJnqSxcLzdNbvkGKxrjHlLmk3ifqhQ2sOeXblzTrAKAt3L+b3nD3UUP7
         WOBnWPonQZ9xeOT76/GOtrrLdhSOfXIslRCMB599e2K1G5t8q6Djm/Zmrdi2jPUyfWXv
         zQPKYNXyDJH+3xe66/D1dnazU4cIU+rMMaMIJCTpz/0OJqhjOdsXvCr8jIKiekvNLrh5
         VM9gIvqLVvBw/wv6q4o83lMnttZPX3v9sWxpppeS41WZW/j4jI9hZYS1RKrvtnliFzzR
         KSVU6kCH4pXVFzTzU3FjTrku5x/au+36g3+azytx39m5HX2/6RME3LNCEsVTa8tVFZ2u
         Pzuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789227661; x=1789832461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aV0hpfIPJg5R8Lh2IDjZGOErZ14awD8uz5wwI/na59Q=;
        b=vUvT0H1cgUCfdgMQvd2i5zIMgyYtDcbXH5Nku7WBakdbxviYAy7sk67Q5UWU0gLezV
         mps3YgK6iuEKKcP5DSL89SJ5IJ4ufLQDgStH2Q8lWqSSp4qmeetXFwDjTw65uu6IKAv0
         RPUyNXUWsJfMWVikQ4Sk3/a9nesvviddWAl3VQjAr1hpMyBTFDOvXCGNHNwICc6OEqzM
         IjlWCER17+tmRQ01U2D2tqxh6H45qxq+0ve0LHvL3LrtKnYJATmI+enrbKjBgArvQywA
         mwfOSU4X9X/G605xzE2MWd+xiJ5K5w8BP25BNrWEo31Qln2rHhjyPq2zXFy9a2WHbct2
         32Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789227661; x=1789832461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aV0hpfIPJg5R8Lh2IDjZGOErZ14awD8uz5wwI/na59Q=;
        b=m+mdAltnVWmGk4dnwiybGRMfywFILlnyj4jqwQd9ptPTlgnUMeYnmJWqgxIZBSJSEe
         /HXKIshgH/CqMf2yAQ1HMlALQWvbOWqPVWkuF7ttLJoX6MKY5PZ4OwwER834+SulPAhf
         Me9JF29CB5U1zIItAsJTaVx3R8D/ERgGolord9TZEoHlz1YJ/oBg52BYOiopfBqBKeEu
         uM9uTRC1rrbVQ8Yw1Cuj4gvXy4xTnGFQfO51wLF6WFfJJQRSZe2v6NPoC6leHBr6QMM7
         S2/b73CVK7DJU6Gpuxx1pPaLHi9koUTwcmn09laW2Z7ThFOhvC4yRoIo55nNV+Nky7i5
         3j+w==
X-Forwarded-Encrypted: i=1; AKwUvBz3VreklMvrPGfh0bitaAhg5Y4KQt2AmL63u78WxsAzGf+GH7RBQ6gjGcuQg2igI3PI0t47VWI=@vger.kernel.org
X-Gm-Message-State: AFuF++kN/c0g3HJFNl4FcSN59BVd7/H8QR5wsYKhnmKfiAuYlp5Kvad6
	WfbdnaHUtf1FAPLOU/pzlQsS+72UYG70Z+FAaCR6m7AoX1fzxe/Kv7T8Yr5iqR9CquuVN0fLFLe
	43Q3dgQ5L4kbR01V4qtFGCo2zpRnYJoppWywsuvUi
X-Gm-Gg: AYBFou38mMriUS+kYSDqhaM+lB4AWnBzrf2o78P9UW3g3HA70nR4sHSk4+YBUY1T/Wg
	/3w0spdn+50sLlNcd1eZxp8YLavb/UOnp3hNTBSh8OLYjYPZRxUtZvwqmz9hPHV+qD91DU8v/FX
	WR9XMcReILkUtnHUJOEIGJZWCjj7Vf/f7dPw5gIUkPKH1V1bBjuzaneG718qzJFvb2vMCuAdsjL
	G2QQAnWfOIEH2Ov7kgHFbfFXFLuSJQxpSI+mXJspgbK2y+pQXIxXlAW3z5igdCFH6Q7QQwkPB9j
	bBHFIYY8U6dOMNZ93szYcISW8CD5PyHFlCPmzmQFJDXuImoJ+TWoWwUzon0b9IjzCNrtU72mmbn
	rqIOm3pijiwH1M3v6Hu8jyHpnF9YlmBwvrmZwkQjt4OVnOaZpB5XJB3neF/2lXlhsN80=
X-Received: by 2002:a05:622a:4208:b0:530:318f:3086 with SMTP id
 d75a77b69052e-530e7ee88eemr49178821cf.17.1789227660302; Sat, 12 Sep 2026
 08:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911114922.621937-1-edumazet@google.com> <a53a81cd-88b6-4db2-a0e6-ee3dccfeef42@linux.dev>
 <CANn89iJw5P-wARumRgxdPaHXBJ3qF0zu6FNaNOFKonyww9AJpg@mail.gmail.com>
 <d9cb00fe-85fe-466f-b6ee-c5694d134ed4@linux.dev> <CANn89iJYEGDBcFxC3kh1KPbvxs3Qh0aU8YrgH=h6xdHMJm0iyQ@mail.gmail.com>
 <8a331d2f-526d-4aad-bad5-af84073c183d@linux.dev>
In-Reply-To: <8a331d2f-526d-4aad-bad5-af84073c183d@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 12 Sep 2026 08:40:49 -0700
X-Gm-Features: AcwNN1VPVpAieUdAAkZUCom7ApcsWzioqYMQ-njNpdKxyR-XtblXfAzdSk6JNL0
Message-ID: <CANn89i+N_J5DkY8SD66RwQSeqFWzpa3CR7fpTYATZBPZazM=Ug@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: do not leave stale header offsets after pskb_carve()
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 8:29=E2=80=AFAM Xuanqiang Luo <xuanqiang.luo@linux.=
dev> wrote:
>
> =E5=9C=A8 2026/9/12 21:44, Eric Dumazet =E5=86=99=E9=81=93:
> > On Sat, Sep 12, 2026 at 6:39=E2=80=AFAM Xuanqiang Luo <xuanqiang.luo@li=
nux.dev> wrote:
> >>
> >> =E5=9C=A8 2026/9/12 16:57, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Fri, Sep 11, 2026 at 11:38=E2=80=AFPM luoxuanqiang <xuanqiang.luo@=
linux.dev> wrote:
> >>>>
> >>>> =E5=9C=A8 2026/9/11 19:49, Eric Dumazet =E5=86=99=E9=81=93:
> >>>>> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
> >>>>> the first bytes of a packet and reallocate skb->head.
> >>>>>
> >>>>> All the headers that were present before the operation are gone,
> >>>>> but both functions call skb_headers_offset_update(skb, 0), which
> >>>>> is a no-op : skb->mac_header, skb->network_header,
> >>>>> skb->transport_header and skb->csum_start are left with their old
> >>>>> values, now pointing into the freshly allocated (and possibly much
> >>>>> smaller) skb->head.
> >>>>>
> >>>>> For pskb_carve_inside_nonlinear() the result is a zombie skb with
> >>>>> an empty linear part (skb->data =3D=3D skb_tail_pointer(skb),
> >>>>> skb_headlen(skb) =3D=3D 0) but skb_mac_header_was_set() still true =
and
> >>>>> skb->mac_header pointing far beyond skb_end_pointer(skb).
> >>>>>
> >>>> Could you please clarify how the MAC pointer ends up beyond
> >>>> skb_end_pointer() here? The carve helpers allocate based on the old
> >>>> skb_end_offset(), and kmalloc_reserve() adds room for skb_shared_inf=
o,
> >>>> so the new capacity shouldn't be smaller.
> >>>>
> >>>> The dump shows mac=3D234 and end=3D384. I understand how the stale o=
ffset
> >>>> causes skb_pull() on an empty linear area and triggers the BUG, but =
I
> >>>> don't see how it ends up beyond the new end. Am I missing another
> >>>> condition?
> >>>
> >>> skb_headers_offset_update(skb, 0) is a no-op, so mac=3D234, net=3D248=
,
> >>> trans=3D288 and csum_start=3D288 survive and now describe bytes that =
are not
> >>> there anymore. skb_mac_header_was_set() still returns true, so drop_m=
onitor
> >>> does skb_pull(skb, 234) on an empty linear part and hits the BUG in
> >>> __skb_pull().
> >>>
> >>> pskb_carve_inside_header() has the same issue, the remaining linear d=
ata is
> >>> shifted by off bytes while the offsets are left untouched.
> >>>
> >> Thanks for the explanation. The fix itself looks correct to me, and I
> >> understand why the stale MAC offset causes the BUG.
> >>
> >> Could I check my understanding of "far beyond skb_end_pointer()"?
> >> The dump shows headroom=3D0 and headlen=3D0, so head=3Ddata=3Dtail. Wi=
th
> >> end-tail=3D384 and mac=3D234, the MAC pointer is head+234, still befor=
e
> >> end at head+384. For this nonlinear skb, did you mean beyond
> >> skb_tail_pointer() rather than skb_end_pointer()?
> >
> > Is it an LLM which triggers your replies?
> >
> > Do you have an issue with the code?
>
> Yes, I use an LLM to help analyze patches on the mailing list and polish
> my replies. I only reply once I understand the relevant code.
>
> I haven't found an issue with the code. My follow-up questions were only
> about the commit message wording.
>
> Sorry for repeatedly asking about that point.

I gave you a precise explanation in the initial answer, I do not think
I can do more than that,
I have other urgent issues to address.
