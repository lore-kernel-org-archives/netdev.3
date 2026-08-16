Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADD33C198
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786858197; cv=pass; b=gZpfrXKA8zWny+JbnXnLjFipNZQZvkLVmTh/8JQ8BgFNyxyMmB07oneOS8AZXjQcMLVbwBq3U76vDBf1TbkLWOyhsFTIKFbLe2a+VQUi7ay3ZP6gOzvpTDsNCaOrNiUKtu2wO8b5Q3wVriMkR0ndjN9lFI35XBxD7fufWIGF55E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786858197; c=relaxed/simple;
	bh=0GMogYTNpbTF5VIQI3Tj0Z3WDeNmKEadOpeGZiPUrEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dnd5vy4xifClSrn5nC16GkAVn8J4tnWb2mzJYD/Slq4Y0UQ1a/nLZQA1OTmzrvdAE8+49EZIsuaJtybC8TCdy2hrtLMtGNaKfwt8tJQx6MQuXLlRDI4coIdzYfrHqbGtNaC1qPSjUkdEpq35ou+OfsAPAKHlBFzEHCv7DFdY9h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6efumHj; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6efumHj"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2022323c37so288953766b.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 22:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786858194; cv=none;
        d=google.com; s=arc-20260327;
        b=L/ipFYJRvpaDhZPqzbV63Hp2moOOugNQN/h1JMvXBmR3GgUcTdnaLqz5tHBZ7UgWIX
         PFa4xMRrcTsBGjlkbdoarYg4KLvrppg2JREpwpRtH7auWiXxtT915VMGGl4KixD9bfku
         SKn8mJU7VpsplaHuu16A1xUEMKnaJCtpDOlDxUludF+j80qY888QsJPsEhEU2DlRg011
         KnrAPJPXPT5YdKLkv6YCEPjQK4np0vCJit/xbqA4pPT1J6u7zr95wRc80Fs6alwpEy6v
         CJro6o0te6pn9sAPI/KQlCWGeq7+wujK5lN2r5o+Tc/o14BO276a69qjS5gCE3JmyZg/
         xg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0GMogYTNpbTF5VIQI3Tj0Z3WDeNmKEadOpeGZiPUrEs=;
        fh=iL0iEV4AHQxfGf/WPI/HVQ7GVVTlf9FiwbD/1gWXnFk=;
        b=KNnKJn7MLMbSrhAAsp8ruIA7tIfyEDCiXjrfmT9CAnTK72nR2LGapwj1oMxRgpbv3Q
         kBOuhm/mDu+fEcWdb2IHwfAJRXNuqH+mkxEN+gU1tgS7zg4HKuy4UneogxqofThf7goO
         ENMVfDHlEFDJDQ97rL4m9ekZNJ8d0f3mUvDu8PS0K687AcIS0mdGqLxoV2jIax54yEVD
         W4RYJiTFUr8zPtn4k2q54eRaTyP0tiTCzAl8ORAiR+WHaBNZuH9xUtFFL2hFquK2lAP+
         28cuikcqiG87kNTFqLJDJqUmgCn5BpA0NrbkCI/GOKCUow2tesGxTBvK+nvBVXuFdvkv
         P2yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786858194; x=1787462994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GMogYTNpbTF5VIQI3Tj0Z3WDeNmKEadOpeGZiPUrEs=;
        b=i6efumHj/UP+vr0j5972EHSS85O4+ucNdfTNSumbKdzLdUK2PqmMDO0qUkMuY3r7MN
         NQtMqDc3zLRBXNWr7MWgkxeAYe5AX+0/ATwihgSODSJr7uWKlbPbn/PjrBkXsBcR/S/V
         nkVFuUEWQWt5eeDKjhDCoToqJiqMnV1wIRZu9gvrBM2FD3wuqOBvh4Z+LoyLuEl2Xo8k
         QiJDB+n8rHrGE+ktrlHj3dV4+DVluPb4T3UnWpDUokyRrMPPCRprYpj/jhrZDP6iZvbi
         1NzH63US02YXSPcZECYasB9f7TqWeWkfa/cHBeTXPPVrDKEA4EvT09C5s0dNrDBHGwEQ
         xj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786858194; x=1787462994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0GMogYTNpbTF5VIQI3Tj0Z3WDeNmKEadOpeGZiPUrEs=;
        b=A260j29zdHRPnrNsFUxoTX0+oNM1N2METij9V8QFo8ZVS2goOA6RvZmDfsKomkGPjz
         jaCqcEDN6YbSRY0nBCSw+ICpZ3GqRuc9YmVZ5QbOv95J1WQzCABXvaXNLrLhWjRkPX3/
         pRwO4kE6+kjoCjGkl5/z64Q/ir63E4y7vh3JxZgptTxo72La8DC2oax7364T2aGruIR3
         s/XwS8kU974qrSZZQpPSFXHFzqpXizXrdRJdlIhEKwYYtHnF12cqni4cG4fq8omKJjJw
         lSKh4iF2h2RNj6cE4XcI7W9QXaArLrlEUFZWgHfA/ibrww8TjTGMF5/V+zy67dsgb1BV
         Ca3g==
X-Gm-Message-State: AOJu0YxI1udPkX5xwblq91g1CVcxJZ8OYA9BsYoIFtj/+6125lsCoOBF
	R86wCcTsV575RESVhbbbzempMlEh2Wta4B1nbyGU8EVJ7ELAB4/UXMwOoMsxjliUyZXLgrvcQNU
	4cvOEis2IrzUw6M3Lx7J7RVwcY33kIuZYlZM/BX6iDXZZ6g6Bo5DxBPlq
X-Gm-Gg: AR+sD12czltGV3xK4Um3qf4m3J7B8lwz8tirXdHvH+L/BogQAqwbejtHskmUx8VerdE
	r7MNtd4hUf+KX9nXvYT/SIahvMqrc826WAyFvjMpkb0yyKwxJPoeoVRNuU6TzmlS9HK6CZO2acZ
	7smwlDaA6WEYYv9O6uNNJLIlJrsYNdp+zNgmdCFVPZrAIUPN2ngmbkXKBW+iSDp+s161GlMSAdJ
	lXnmvC8+cAZ5broISZgWWldegfhuh8r4U3ljjP9dk17aCmziSTz9Sc/Q+qA5G4CS/D48qT9jAO9
	k+6RUyLHVbyOgjCO/LpBtIcqR9flixB20t7FIAKH6Bj9rQ==
X-Received: by 2002:a17:907:7b9e:b0:c20:33db:41d3 with SMTP id
 a640c23a62f3a-c2129bd0001mr748392866b.11.1786858193993; Sat, 15 Aug 2026
 22:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Sat, 15 Aug 2026 22:29:39 -0700
X-Gm-Features: AcwNN1UyYmeHLBsfX_QGjqXqAtj1GIDQi_SA3bNYfMThTGhnY9c3uKATUeY0Mxk
Message-ID: <CALuQH+WN+xftDONAk=T8zeB1qF5y=yaJ4F23DAg4W6puP+jToA@mail.gmail.com>
Subject: Re: [PATCH net 0/6] gve: various XDP fixes
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Ankit Garg <nktgrg@google.com>, 
	Tim Hostetler <thostet@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quite a few review bot concerns on this patch series. I will respin to
address the concerns and manually run Sashiko to hopefully catch any
other lingering issues before resubmitting.
