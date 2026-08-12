Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C440927A
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527784; cv=pass; b=KguF9JVcLZdw24P8F3vXTr6O8/Qbsxqj3trOQypd3MGL6hhfKlbbfE1/kFvYoyqfrKul/NRpGGZsXeXvvkqkbZPL1ZTFdyBgvzhchbSospwwZo+wKTLT2+eDedHADQw/MuHMibNr3MwoOviPt6mS+NDzEqCRsBi8V/VYkqg1rDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527784; c=relaxed/simple;
	bh=ve7aPJXVQM2J1syEL+rOQPP0Q7Xevv01p4RL8g43uNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/b71dSzQdeMMS1zuFAk2/QsKzMCVXkljVoROF3kL3LvEsKkx55FbXZ6tkG/eW9skLxDxRL2aSxa7GzU2luRLy4ZGLliYtpg1Hw8MlbvjUEWNjAFT8v2xtnjtzvCQozOAy4EoH6gTsKl/VVaziVoDhMqrsmt/Orlk7nu9pUurr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1DOGXQz; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1DOGXQz"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so3028717a12.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786527781; cv=none;
        d=google.com; s=arc-20260327;
        b=U+oipsDJiTrlfxoZCn+DzQIZLw757H0JsHeDtcbKWpaRnzF3P6fw9mRrq7r300QFRq
         76wAtrY6bSGT5cBovFh66gfcIxBlZRek3DquqZT6XZ/fzBUQxh2C2fBLdUB18z1uF1Fa
         qQRmYkcxfARc42ThJnu+IMuj+Izvp+BPBKSmQq7PtKPvd0U5c+GPdvO6dowDN5uOpG4/
         AJ9+jGEKHRa1dOR4GMt5KFQGG1kdolpnHQAzoIjfX0k1o8/s2xiYIPYkckrSdfksNr5M
         OyNsTuKOJ4rkBa4O21Kj6IU9FEUcQqo72UK6odfvNmmS/MKvtNW5yRLE5a19K3z3PQut
         k7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zEhZ73/l3LW0qrfWxddjxawqzrlD2pI0x8CKLdSZgZM=;
        fh=crNACndDIJnLbEqRqTUryrRCnDmhVwuZGHMtAw9fyuo=;
        b=XMx8JVgbvHzA/HHUSjrY6xzJjoygRC0ZqKJcPv8ai8jRa7RpiwBFKOeNRGbZQ8q0Ih
         ZTZewGbu5Wg7r/v1TZ1DGGHc6Tk/gDw6VyccAqC/N2AXnlX4yXCEUrhf/uHb7IE5JaKU
         eHXZAyG2b/4YjGKnaM2dljZ7dPQlX08SeL2K4wGTxVn14u7cONRP2OTFg2AlGAOX93L8
         A4smWbfuPQNR9ShEpoY4Q0zXC1t2xGT9YlKVtsLjr021o7p+wqf9pccx4VrfMc1tmLWf
         PkhSoQNPHU5sTV/ROqPScVgJ9YRdEic63fzQSAsTZWMiJ2dK7InYJRSUQCsySg0xKYKI
         PfqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786527781; x=1787132581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zEhZ73/l3LW0qrfWxddjxawqzrlD2pI0x8CKLdSZgZM=;
        b=A1DOGXQzE7oi3kAokfhPR8NcwBT4q5JdvhsyA3ztJlrgdRGVNgPFuDHjHwKYXzLj7h
         23syhrQjICO89kp3dpYKOVJM01lJQYKUz257tbZktZqNYRSrB3emAwYIZMWyACp+ov/n
         D5ggNqfvE3/p8DijJ3jNxWR4VlF75tARY1e7Y6Z7UeeEgdNAUFX0tgl2j3WGBhWVXMNt
         MbZxqwEqTaCeZol5ijS4ukB/+7RirpUBjupT1P1rlT2NMuavIS9ZXJh0CfG5L9M/Bp8K
         j4pOPw7/UVkpIaH+BYdKzB86ZXhWg956LTXBXGaI6DDee7WotBP9nghaqjvgvF+GTReU
         DtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786527781; x=1787132581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zEhZ73/l3LW0qrfWxddjxawqzrlD2pI0x8CKLdSZgZM=;
        b=OWy+MaCWLpAHCyVPu6Uf8EO5D7F+nQ9XqDlz7Rab+uDO4ccQoNlAu+I+R9gpd1ZuOu
         Nrr/dTz8MMk0eK3gzC6mjkb/5RGJ74pSjp4W+jrOIvGKMRIOJOST+a8KyuUyKOFq0VKj
         I+RMRs9S0lAbPNPqMSbMsWmXKFNHcP32rEkOHz9mB2M4SGUtsC56yjh3ct4gxjN+FvoF
         rSerURbHFbkfom11+z/vDYcmlPIScCkUXiOC0AF+qNca2tq/gUf6lDAlR01MzxB7FWSi
         IY2ehUuQHgw7TYfY9/A7V5hqxWbUq3hYvzutQSOmek6r535F7SF7uSonEeBQg4TSjuhq
         YAoA==
X-Forwarded-Encrypted: i=1; AHgh+Rpv+dKfcOP4v2vAPkmnOW85J3Z3xTHiNN9t36IOXsGHuOr8kL2WBnT7SSL8VARrYMda+brFWug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYbKMc8WQJFFzJPNy5kU+TaqO7dS6MWFk4087v9etEmmr7J3Z
	v5hIl6uyHmAPbzvcpzuK69pOEhakZUu+pnd6Mvm8sil/4iKyyDOBToE6BL6lw8TJaGfWwvIlnSc
	H+nkf6eQFmjbVAgarqnKnXr9KBXrRUAkB3S7HYBw=
X-Gm-Gg: AR+sD12n0NUQ6Icv4psv/GUvEb+p3t94Ya6RQInh+buaHn8WZKaghMuIGiYSVhhsj8m
	0NeNFTiEhKdQnaWKcsH+K/nDheOlrmHwAuSlmO20nsQLbNt3UWc1Sjn2pvgcDCJG+AksI6Wg8kG
	ce51PbJ5PrSso7s+ZHgR8NptPQuI/o9fHvJGN6qgqLP2JEcz1NnP+/hyzQ/Ho4cG+pZDCNBezkd
	Fmc3vwpr+5bM0XskNk9sb1RlDk1YNW6mverb3mIcaggO63fsrmLqjqGrX3haYj77QRL1sbLx2M0
	7cePN+muuGA9QY2B5gKBTEH/GCgWT7dh/JUoaXjMyLycceIE1ijt3VXqpfGBlLmVkSXKa8VcsYv
	w0kWak99RnJ4uY3XZFnjm2elve3FC
X-Received: by 2002:a17:907:c510:b0:c15:f55d:f0d8 with SMTP id
 a640c23a62f3a-c20f5080248mr160120966b.4.1786527781423; Wed, 12 Aug 2026
 02:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728132836.41868-1-meatuni001@gmail.com> <28b1e429-39ad-4bc1-aea5-a17def952da3@ixit.cz>
In-Reply-To: <28b1e429-39ad-4bc1-aea5-a17def952da3@ixit.cz>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 12 Aug 2026 14:42:49 +0500
X-Gm-Features: AUfX_mw2IGBLs-IZzYD31HN-o5sEleYCRUJ5A0oB8oqNnldsCzCKU1VQwAdzs-o
Message-ID: <CADqcGBmqXjyb1PJH=bBZAtuMLM9+GMehtPCGbQ-PNLHZ6VEQ+g@mail.gmail.com>
Subject: Re: [PATCH net v3] nfc: nci: fix use of uninitialized memory in
 NFC-DEP general bytes
To: David Heidelberg <david@ixit.cz>
Cc: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David, Lek=C3=AB,

After analyzing the caller execution paths and commit history, here are
two technical details worth noting:

1. Fixes tags:
   - 767f19ae698e ("NFC: Implement NCI dep_link_up and dep_link_down")
     introduced the POLL-mode atr_res_len subtraction (2012).
   - a99903ec4566 ("NFC: NCI: Handle Target mode activation")
     refactored the code into nci_store_general_bytes_nfc_dep() and
     added the LISTEN-mode atr_req_len branch (2014).
   Since the fix addresses both branches, including both Fixes tags is
   necessary for proper stable backporting.

2. Return status:
   Returning NCI_STATUS_RF_PROTOCOL_ERROR (as proposed by Lek=C3=AB) is the
   correct behavior. In nci_rf_intf_activated_ntf_packet(), a non-OK
   return value properly skips nci_target_auto_activated(), propagates
   the error via nci_req_complete(), and prevents nfc_tm_activated()
   from firing. Falling through with NCI_STATUS_OK would incorrectly
   treat a malformed ATR as a successful activation.

I have submitted v4 [1], which incorporates the NCI_STATUS_RF_PROTOCOL_ERRO=
R
return value, includes both Fixes tags, and credits Lek=C3=AB with a
Suggested-by tag.

[1] https://lore.kernel.org/all/20260812092423.161497-1-meatuni001@gmail.co=
m/

Thanks,
Muhammad
