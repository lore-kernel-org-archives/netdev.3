Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F7330667
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033618; cv=pass; b=C03ILrYagDGSlKp4ZbqcMr5sSte135l8YkvvBbS8Wtz4ldMxcF4fhNxKNMwdhD31R7I+d/bqWOjbofMRLddmdsjSejk8mi85+RpfImXN8dGfJaK+hZw4kOczGNg+yiMohw3tiNiCURwtbpAQI9To/YuZKkppZ+CeU6lg8ZUFszI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033618; c=relaxed/simple;
	bh=wT9VgK8WGe5LH03zxzBpqoG32taUZAX5doc4MZUXGaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLQyO8bMf3v74F42Cfz26QkMXLulqbHGYAykXs7HmO/14g/svpgukokP5gjS9zzB2kN1VyUDHS/geim4cXgzY+4CfBybWrKFRiZxoPZ2N/UeR3ywKzPdQdU2FWc5tQHS3A4bQYq33xXXJRG4Wo5EXjG/X+aUYvgOfSM1pIrv51g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAHpY28J; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAHpY28J"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b351eaf81so58105691cf.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 01:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775033616; cv=none;
        d=google.com; s=arc-20240605;
        b=A3zwqZXZc4i8inxIE8oyCr5DWSvjUGXsbvE5kJOhhjrFtF4EA2QfmJhiwvEyNQCkpW
         nn0g2xM8Fo/wyjalMVzIBA7VdHiUCexjfzasQNKPWEmH7RafkSs0dYXjMtt57faVCUqc
         ieyub5Ns0m7Ck5rKAZeKn53C7KkG46LM6m1L+QS81d3WV4Xm5RPUT71YLdoL+WIIxBbV
         64UWfx8Ck/i1/s+c54BXmDsOq7qVlWUePY0JTcL3hpH0ieG9WAhG1w8XmMafm8LSO+I2
         r5zzUmci0oeXh9E/gI8zn4QUJFfymXjuPMJbrHlk19hCq1lshITOciSCtxoSTL9dNvYJ
         dDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wT9VgK8WGe5LH03zxzBpqoG32taUZAX5doc4MZUXGaw=;
        fh=AE+XXZPku6tuai1v86IUmecr7dx5MEqKx92GLonjM0c=;
        b=U3r384/j7eRvnilnY800YV3G7NU0jVC3Y7i8XCBeBj1MfzNZUIssygpoUZkxe9xSEe
         JW883/BVfYRkG3AFm0drSaU2oUMNuze+TFp4dnDrruVS6aliFZWh+jvfsIFuaqfpwVyG
         cPVJwQ+BAK0L8vajhaIpETF9VjbvCso10ihOb38KBgkL/a8BKrcHvsPbfp9el/ob055W
         PsXp0NZDA/YYYcS02az8H1e1trjbMwM7H9BHEIeH275OnOXWP2W31wQz15mr6njYJm9A
         eyjqdq8xb+0Gv9WbZ0SNEFxFSoksCmaLwejecxZTYTkMg2p+5zo7uktwjvhIPh7tEis7
         A+Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775033616; x=1775638416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT9VgK8WGe5LH03zxzBpqoG32taUZAX5doc4MZUXGaw=;
        b=VAHpY28JJ057qJDXNYRDKg53OzJdBN+Ke+DQABPMiZ6vbFYsAnmZWM1f0hvLHJchHH
         S1XJa1qoanP8S52kPFVFFSqkUHKtfO4m0xKa4bOhmdfKxTr2oxK4Yvl5VwqJUabSWVf9
         +o4esoiYehDhx199sYtL+UgkER1VDC2CzVL1ph+r0lXh1I942woWhX1GI9Z7i5/ykVAA
         NCWOm+cwYUbIWmYq14ayXjStn8P1eNuLb4Pq46rOQ8YiWzPXsZ0AjwLyJu+opQa2Opr9
         kn+2Qp3/1TGl8N+7zhZ27maDEHW0Ir/OeybZDpd5duQNwGbFDP9jgEYSMS13iEopFKXB
         dV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775033616; x=1775638416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wT9VgK8WGe5LH03zxzBpqoG32taUZAX5doc4MZUXGaw=;
        b=f5oDLTOPNlsbU6PD4VZGDCLlzE7wYpKQM4Nl1gu9CefpdI8CkZoL2wHeD6grCOmjfP
         m9QYXi3UnSvc1kL23N1paLRvhkbkkenTeQUrCiOD0Y8ab/PBYzTQsiuPu2e4Evdgvi7t
         e0g0hFkVQS6DlyzsSapvrUkRErgnMGTrNSv+gCLGVQfUAfnJqC+budKWIEwFJ65dTNTe
         1ymeO4TC2cZMmFJnlVrqS2aNnneUntTnu+de7z4K78DU59aA7iPA7rtjvSVDnI99LK0E
         zuGwDcjCd4JXRlgZ1sMfi/9WHEMyw9DiS25fNOC8yIqJbN+MwMIOS44J8pnu7hiRa2iw
         TbMw==
X-Gm-Message-State: AOJu0YyBuMrc58ZtLUs+lN4YxtP+BYO4b1vGCtSXL+wqFeOzmqELOa2J
	uCskxY1pfbImBhA6L9y9ghaTIc8XNTeY9wg8miR5MMuquBGdLisvUpaeAaFiaQF/0YJXlzfc3U9
	j7Q0YQrRvOqEWybRI5Iqiuvp8j9hesLDe/1Cfy/IR
X-Gm-Gg: ATEYQzxunSudt8/+w3+ghQAoWKDmUJg+5I1/bdYn0ru8R4FeaEBftfRzh0InhY/wlPJ
	PqzgSErQgRRxeoil9tC8rKyMKQmD1q9ehYHVsgLLPh2mT4UJ6HyXUcCIZx/WUSsC36JrTgU/pKV
	l8El26fz+3K3SbC3jElK7/pfoCpLk4KzIya47F72wBnVECLlsuHPs0iQS0t58hVBfUm1cQ9Erpc
	XtiekKuIFrxREwTXBvEQrSRDowZE4l2aWNUCVKL9+l5WP/4rOvwgNYDP2vAt3SN9N5h7QIH7pue
	Y1EqyZNodBInJ0tW
X-Received: by 2002:a05:622a:148e:b0:50b:3893:a2d8 with SMTP id
 d75a77b69052e-50d3bd57670mr36524641cf.63.1775033615624; Wed, 01 Apr 2026
 01:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401081741.4273-1-fmancera@suse.de>
In-Reply-To: <20260401081741.4273-1-fmancera@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 01:53:24 -0700
X-Gm-Features: AQROBzBjOHv0uLoZXSvxK-yaPKUsFTpXvAXsyOYQPovCGBYrLFrpG4m1I5hAzdY
Message-ID: <CANn89i+j+MRPEn9oO+7W5+o9vWsfFz5raSFzL=RPwTu55iXkRg@mail.gmail.com>
Subject: Re: [PATCH 1/2 net v2] ipv4: nexthop: avoid duplicate
 NHA_HW_STATS_ENABLE on nexthop group dump
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com, 
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, kees@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 1:17=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> Currently NHA_HW_STATS_ENABLE is included twice everytime a dump of
> nexthop group is performed with NHA_OP_FLAG_DUMP_STATS. As all the stats
> querying were moved to nla_put_nh_group_stats(), leave only that
> instance of the attribute querying.
>
> Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user=
 space")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>
