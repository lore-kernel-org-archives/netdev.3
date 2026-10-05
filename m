Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA53D47534D
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200562; cv=none; b=IistN8DFJMovm6aeU+Jf1oLoR1IUWtJ2RdmUNJCqEaRPONULUCnQU8Kg2JEtfuOv8QVyyM/c+U9FVl+11tGZNnPJ96MRh7TeSdhniNuoHwpSJBtjoyNEOSdbvys8f881o2ZH+Y3xpFbDLo+4rGFo1x+Z2CZWCrL219V/Gbqz3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200562; c=relaxed/simple;
	bh=RJHZveZ9RM6slECcVWdAq+Dfc0/PIILWrjCkq3aWuws=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=eAN8E8H/POZOVwftUYvHm3ognC70K/xf8Q6d92VqO5pSgFg461DW5SeN8CxS8Zc/rkUncH4BS7touPQVLWTZJWBINYNxllQ0uVk+gC2XVQIyJqriNRQNtqQqRkG2viu8fDm+XYTXprHs6Yf5On6L9fxGVQ+BK8g16YwlekCtxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBJaZSrk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBJaZSrk"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53396adbc53so17428431cf.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791200559; x=1791805359; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QCcpISpI1wOop8ISeCzO4aGfuyNbBFp2wC4CQXpEbyw=;
        b=TBJaZSrkIkbqa5VNP0jba6olH6Vv5+9MxvzSrIXj2T+l7mzp5P+T6vgaZYSBVamw9Y
         b6koXT5CNX29UkQbmyia0w1M+zRRzZkV07Z/XKIIOqKz8FTn/i5ETXuzxguPX73cBUlC
         3rbLRcZnBfpD2YbV/fyZbCSW4iE1S/GDuZR/F0hv8IMDHl69eTN0evOd0aQMVqowkRI+
         mSz3FhnBK8LA1NnU1u9V9HcfLTkLT4HS193RBmXmViaSsEKfu+7mUDTDrlxjpvzMo28h
         pSqNQ7aUHuOuA8Lzgq7EVSrIJ8yCurFdDRrOjwiwInCCgOl2OxeCwJE8MevtX+l3VIhk
         +xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791200559; x=1791805359;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCcpISpI1wOop8ISeCzO4aGfuyNbBFp2wC4CQXpEbyw=;
        b=EhroFWuHamIRz2F7LjPt4hopnZuo+pVPzHF52AkpCClnx+sr1ss/NAaFOrFITviwfO
         6+XuB1MI76JraySkOi2h0mQmOMs58odC5NRVYJIfC6VpJitD0MxnBcahQqsxAvFtnY9J
         FnFiclFPpQ/sykmrgoCrCGxqkuF3Bs1eDwjdVLrdcQMZ4jrX6HJMxHNADSCEpO208oXY
         kyfNuMPO6DLMyifwCzaC7+skoVgGcxBJ7zDvKP576EXzYOPepGrsqaVcScrMpaI5KtgE
         rqVsvowhCLRl+NjUZyobnRXnnMVBi04rU05z5PNusNNNndwQO4oHLSJxc6+eHf3FeZiT
         eMGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwY0RTjBMwpyuEcwoXmPhdqj4ubrTHP/Rw9WIdC7U0OxPBaxKgCfJKLJNvgk7Dv5bpQALqNfes=@vger.kernel.org
X-Gm-Message-State: AFuF++kSdXI7DCmTG7L0sDmB6LgR5Dt4i0DajxmXQbMwVYapjhIxO3dW
	pgl7VdGJDkDPdQU2WHcrKk9zo8j16XvzNfqBGsdxcGusw9LpsltRs6kG4F/UNw==
X-Gm-Gg: AYBFou0scMX1r4LWq7hZ6czN4VGJK14RIy0rjcWkZy4h+vXBQDZ0zakCaWWT0Q3kTh9
	AtYWTAJwSL6gO6osDJA9URNa70wJqUndr2CwJUlKIDPZdknlfGRc7lmlDjUsXrjqF7PDdwtJxbe
	SDjYd84U1ZkE8k/jVYCl2Ndjz+E2YlSSZt8vZdbpMRRTrmaZqsgPeGfMQi3DSdTKjkiFa/pL2nX
	kza/KP1s/dOiCKEXmqz+nsczp4xzisgqDFxt8N0OjAl/lxmP3yOitj0nPn8f3Fe45yMX7nXwZlg
	P4bmH6rPONug5EDxX+T1L9gZ6h7czz8Vxa9qgxac7YwNJZptKjykizmNlpnB8bsVgLPSBASf4v1
	2dT2JZbGQlI/QOVzqssmoNH7rKmxjkR6zp6WoWga6FCCsMs+hApQhtOaZdkbjS6rhfsL6k5Q2xO
	olf8x2/zamcI0Hc3c0yekstw9DeWVNHjDkA4qFBO6XaIEMuSmFfMhd0PO4tU5P9JZyHGOFYbu+c
	mM=
X-Received: by 2002:a05:622a:1303:b0:533:91bb:b81e with SMTP id d75a77b69052e-53511e9d562mr120295651cf.31.1791200559638;
        Mon, 05 Oct 2026 04:42:39 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398d122a4sm93408281cf.23.2026.10.05.04.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 04:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 07:42:38 -0400
Message-Id: <DLWVLSLYA73P.W5X67Q4ROUK@gmail.com>
Subject: Re: [PATCH net-next 4/4] eth: mpnic: add a NAPI depletion check
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Harshitha Ramamurthy" <hramamurthy@google.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>
Cc: "Alexander Duyck" <alexanderduyck@fb.com>, "Jakub Kicinski"
 <kuba@kernel.org>, <kernel-team@meta.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
 <20261001-linux-mpnic-v1-4-6422ee74233a@gmail.com>
 <CAEAWyHdJQsKgHmZSAA3M12jpKhgb_pq7QmBRW59CU-Q_JT8cwg@mail.gmail.com>
In-Reply-To: <CAEAWyHdJQsKgHmZSAA3M12jpKhgb_pq7QmBRW59CU-Q_JT8cwg@mail.gmail.com>

On Fri Oct 2, 2026 at 8:53 PM EDT, Harshitha Ramamurthy wrote:
> On Thu, Oct 1, 2026 at 9:41=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.c=
om> wrote:
[...]
> +void mpnic_napi_depletion_check(struct mpnic_net *mpn)
>> +{
>> +       int i, j, t;
>> +
>> +       for (i =3D 0; i < mpn->num_napi; i++) {
>> +               struct mpnic_napi_vector *nv =3D mpn->napi[i];
>> +
>> +               for (t =3D nv->txt_count, j =3D 0; j < nv->rxt_count; j+=
+, t++) {
>> +                       /* Check if BDs posted covers a max sized frame
>> +                        *  + 1 BD held by RDE as a spare
>> +                        *  + 1 BD of extra safety margin
>> +                        */
>
> Curious how the "+ 1 BD of extra safety margin" was decided. I
> understand the "+ 1 BD held by RDE as a spare" is because of HW
> behaviour but wondering about the extra buffer descriptor - if it came
> from testing or guarding against something specific.
>

The extra +1 isn't strictly necessary. The real lower bound is
MPNIC_RX_HPQ_DROP_THRS + 1, which was derived from the design of the
device and our napi poll implementation. I added an extra BD count
because the actual bound doesn't matter as long as its conservative.
Perhaps that's a bit superstitious.

>> +                       if (mpnic_desc_used(&nv->qt[t].sub0) <
>> +                           MPNIC_RX_HPQ_DROP_THRS + 2 ||
>> +                           mpnic_desc_used(&nv->qt[t].sub1) <
>> +                           MPNIC_RX_PPQ_DROP_THRS + 2) {
>> +                               mpnic_nv_irq_trigger(nv);
>> +                               break;
>> +                       }
>> +               }
>> +       }
>> +
>> +       mpnic_wrfl(mpn->mpd);
>> +}
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.h
>> index 9397010557eb..767d87a36c35 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
>> @@ -148,6 +148,7 @@ int mpnic_set_netif_queues(struct mpnic_net *mpn);
>>  void mpnic_reset_netif_queues(struct mpnic_net *mpn);
>>  void mpnic_napi_enable(struct mpnic_net *mpn);
>>  void mpnic_napi_disable(struct mpnic_net *mpn);
>> +void mpnic_napi_depletion_check(struct mpnic_net *mpn);
>>  void mpnic_enable(struct mpnic_net *mpn);
>>  void mpnic_disable(struct mpnic_net *mpn);
>>  void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd);
>>
>> --
>> 2.52.0
>>
>>

