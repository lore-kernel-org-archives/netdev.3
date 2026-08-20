Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233662EEE90
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250612; cv=pass; b=LbLUhzbnpumuqNFypkCNP4GTh38sGJDY8uTzHGKfLWfRuHCzjFbxGa+e75vInaSt6JKKqCI0Zhgruuq6HXzCbJ2sYqgyqVr0Y+yPcIaJrSZJU0gx1Dl5oeEem22d/KE1LFpcnvbCxvQb6nK15gbaAZtz6iL4iK6w+RZ0Z4HY/Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250612; c=relaxed/simple;
	bh=eE33G0YL2mXfKoQDT3G8JOj79jvMLb8uBRD0O/ujjwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAkVacS5E0HEVDi4G4pKNM9r6QB5jALgISCDFcZX6sXy2LzS7A3uyA3gPc/nzfrkuxgvbAQxchaCJsdbcwDzmr2PXgpcFbjE4/OiTBcZJWRMUdeQ5srzORiUKIqeDZ6n4DDvXlwQfzeptwHX6JPzqxkZ+quQje0V/4Pqh4yrmo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OABourbW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJLH1ad/; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OABourbW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJLH1ad/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787250610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HumBVtrbVxa9+xp1pV1/20ZaLpRsLYNmQXFLcHxUyes=;
	b=OABourbWgXas4T8Ai2WVn+mKQdZNBPiEp2S6gXk1lUqaUtYJ4kTMh5wVsx5iJrCPyrsI7k
	cAmNSuezIEPmrPwOgqFudb5ruRLKROrFhML30hs6B8XbMkkho3ijJz+3AuHoccvJEN4oYx
	ADHhx52oWL6e/qIlcvmY7CXOc5wfB4M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-7fMJ9r57NFy-yMCCY4TkvQ-1; Thu, 20 Aug 2026 14:30:08 -0400
X-MC-Unique: 7fMJ9r57NFy-yMCCY4TkvQ-1
X-Mimecast-MFC-AGG-ID: 7fMJ9r57NFy-yMCCY4TkvQ_1787250607
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so182137a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787250607; cv=none;
        d=google.com; s=arc-20260327;
        b=Rt/QJ/QlKomcWKWLSzPiivyjQdYje9RHof2ln5fL5vY1Kh9WRT3y86VJZ2xEICCzr8
         M26ryOwXC9rle9ZTbzmiuR/VUDpYg/F8AIpSNQx1WuYifbpCttPJlu2l65PbFfNNqBrd
         u96yZO2Uh6uFFvFIx+pwbpBy5uvXKy7+JnjaMsG/8D9zm0ja5ip3cQp8tlNAB/EtR4HU
         XMbfVR0tCUtjKir8bElhqEbapezPlyNJDBuToaA37LHEAXE4zFgbqk6KBO/AE5OiUMjv
         iSSA/DebjUwCf9x3gwHFxF0VcB/vvRy+Ibl1/dR4X1yBhhBTZXC2bHV3vcPITF5Fw/ZC
         Iqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HumBVtrbVxa9+xp1pV1/20ZaLpRsLYNmQXFLcHxUyes=;
        fh=kFbgBziNmGoGEp8tVdXPyfUSUN4G9dqeZYwQKv/pq4c=;
        b=VSlIOBqz0fQ4q/On7uw0PGpUMNG7B5yh2g4H5op49IrRjIuKwKkjML4FAQXO2pinRX
         /YGLumLDHVgm73/ICJw3/K1AgnRrqkXkdNAepo+7ci+emcNwRBo705UP2swjmkYh1lLr
         X46lOpMS0LZuGDcl2A9Ix9cZ+jbjOZIDDTDWK4sZABS9ovwp/1KrHVpoHEhBxkL959Hf
         249LGvNxUouxYNd4aoCL0a51O6bZg68/gpZ0bgap3km86QLXU3RSa7Pmj7TFxov48M7S
         fkiYN302qzqtTuDuP1bqGjJH+rtVzNjaLZ9raM6L3qWUAYlmvVLMfDzQXZ9rbiuIrm6l
         oHnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787250607; x=1787855407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HumBVtrbVxa9+xp1pV1/20ZaLpRsLYNmQXFLcHxUyes=;
        b=RJLH1ad/V51yVkLtuJzq80HB3hkijmEAyG6f0KmEEjiyCiTaBhtdOTm3j5HyeoLUJd
         C0dHTTYhiugt6pMDcxGq94aPmOfTPiEKw9Wl7aYAJQuNqQY98UglEZJ/dYUzbl1AKCLq
         SyEQfGELNUZWcrykJcSfCeOyHzzvmhebKfXv+18lC78wuwduvomsHNsD8CSvE7WounpT
         JJrx67ZQ8EJDA1hUjuB5tQTIvgUQ4cAR62xtrcrW9fz/VlyRmeOMtaydD34uSrfPabVx
         nDE7pd9xzMD/pZgB5Pby1MxEtE31ba0iTZc5Y5jutrilBb8o5v6EPkERA0lr/gtUhE/U
         gSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250607; x=1787855407;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HumBVtrbVxa9+xp1pV1/20ZaLpRsLYNmQXFLcHxUyes=;
        b=RiCryGyLNa7IaC3xeXDqiohL7hu2GvYHfVU9xukA0Aj2bjRp7Jd0lD1XMPkQZkjxPS
         /fYg00C0zeXlMyi382hwnIC34NG1qqavsAOIyQcyRQIpe7axXHTvZAUh6thXG669EBjC
         sEn+9f+CfWOhcgex4zngunFwELvk3ysnKuND8z0nwycrvnXJRHMTxpNQ8EKfzFhc+fH2
         ceJhcpi91/tTA6xQJo1KKVfzttzSqyyCA5CzxYLLiNzySSItOUEVJLzMg60VrNBJVMtY
         bwmg6qQyjdKHPNq5k+v+LpfHfxOHzUD+d7p+3qflTQscdlwrTLPVs3r6PJ2umvMVVMui
         dJ5w==
X-Forwarded-Encrypted: i=1; AHgh+RoTdOULwNdzo85ZfaD4tQmqeFCCEfyZeqZJEjn+gvkg+19FlgCm5UuD3rDoEa/6qqCIXjzbB3s=@vger.kernel.org
X-Gm-Message-State: AFuF++mwUEuyhse3Kye3D1BRVj2k9cU83xfowsCKWlSmN7NqU2LKsLiB
	1aGVkJ8tWoW6h0nOsEa350/yuoEfr0OSwgEz9lZTNuFKdiJtz5/E7hm8qy4YulQvQ1bKEsn0NOr
	z73VqGsb/Lxjc8MsqOL4JP+1BMWkUzxbNcIG3I2PPTAXyh/V5w2NFYO2pICEQOQ3NTn0T/4ru4S
	JF4CJX/mvsPnzpfTkJoue6xlCs8b82mpMN8btQF1k4ZGZAvw==
X-Gm-Gg: AR+sD10YI6SOoQs40GuzPPplEP+3tVyCa/I64CZhKVFxfUrELvBgPxjN599nm8ADg3k
	bfwwXBtqpfOf9oglwQDKrBy4WG5cVhvDDBzOVXuJa2LnSKGz2v02GjILx6vsGC/KCMQxO9yLWGj
	NQ4NqGJE0dcJO7HWxQwNPUcfQD+1+kdQljMEggNdjzJeR7MHmDiXCmFXBEB05qdMVNpIaj2wFAb
	pU0Wn9jrbhvhZ/9Gy8=
X-Received: by 2002:a17:90b:4a89:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-395c33bd6d1mr952451a91.7.1787250607109;
        Thu, 20 Aug 2026 11:30:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4a89:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-395c33bd6d1mr952317a91.7.1787250606551; Thu, 20 Aug 2026
 11:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818141556.64303-1-thwalsh@redhat.com> <CALs4sv1zb7OemFcKRceoO49F8yPSOdZWSkomvU=mGmReR74=BA@mail.gmail.com>
 <20260820103950.5dfa2969@kernel.org> <CAD+aA83e_HP=Z0pXpcxW5j+TUXdgP3Dx8_LGxrMjdVwtERRCtg@mail.gmail.com>
 <20260820111557.49f658a4@kernel.org>
In-Reply-To: <20260820111557.49f658a4@kernel.org>
From: Thomas Walsh <thwalsh@redhat.com>
Date: Thu, 20 Aug 2026 14:29:55 -0400
X-Gm-Features: AcwNN1UudvWstGHCskhH2xUzScpYFuS9oDvP7FZjFOXPTgldDnqdEnzXT2QdkF8
Message-ID: <CAD+aA82ONaO+oNuX448ruJdLJ+ySvsnNwyCLYGGyDZfOA6U6cQ@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 2:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Aug 2026 13:55:57 -0400 Thomas Walsh wrote:
> > In this particular situation, the customer had very recently upgraded t=
heir
> > firmware. "RX queue restart failed: err=3D-95" messages were still obse=
rved.
>
> Would you be able to share the NIC and the FW version?

NIC is BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[14e4:16d7]
FW version shared with us was 238.1.138.6 upgraded from 236.1.167.0

> Could it be that they upgraded to a version which has TPH but not queue
> resets yet?  I _think_ queue resets came in 232.x but maybe there were
> bugs which delayed it later.

I suspected something similar initially, but both of the versions are
_relatively_ recent AFAICT.  Which lead us to graceful handling of
pcie_enable_tph()

