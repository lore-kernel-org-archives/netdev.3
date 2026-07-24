Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2C37A83F
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922586; cv=pass; b=N75k+JMwKeD0uc7KNntFhVyDJhd/hIbYrkNrCst5xxkEXMFn7wTNfrpdTcQXa4wJTyMEAKmWwk22xSNdS4//AiVo1GaGXCb8uYTh/BujOkuHzucSXUymF3xBGF+qxmMjy6DjmceSstk6qnFyMbWJVZ8UzD/oCdmkAkAgJE367s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922586; c=relaxed/simple;
	bh=KHoteI9o6LD+ZMAW+KyLEgRJ9Rhe7f0NqTG4jXtUtSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIf1WVU62KGAFDKdT9wqkRKgJraNidJAGVk9H5ckfGR+mVRlvjmBdHUgm5YI88/Y7f9Uwih5n4vFXBcU/6d0rbJhSJls04Y+yJYfvFRBuj8lyDDvz8b5YatvlvCnY0I6ZhyTJWPBRWly/gD7kbgYiH+WVs4IAcKaVn8M/oRpmJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InHP36bs; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InHP36bs"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f703a9d05so554534f8f.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784922583; cv=none;
        d=google.com; s=arc-20260327;
        b=JAh3bSdAcEDTKVP88zmvsM3UyeLYDxSE0e6zG4+JuOyIlrAa4tKTPYjEKQaEH63vkJ
         +s8GmA+DgfzxQmk65lRgnY8GshR5D+q1MLO64FCuKmp1Ppw6wwNO7DD9DY4vt80W8XWO
         +BOGBQghXr1yeLPQlp/QFdJWG8HY1g72tt5t0+EhbxkXxSvlze1lkwG7XZb+oMFKsAfX
         8GvdJGWErlD3C+jINiaV/JBGIHlzOrkQLH5H2jD9LA0xRSlb5HlV6fX4oUFGouTWBo47
         KOWy/CgRpnuVISa7VvKRmoidwO2xZDVFXsZVzICFwMgI/vu0fpTizyp2EHA5/Z1CjhEW
         E0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKM0STJQOyPUjuFn6Oi7Cy9zywLsBDO5Ren1ON3nbXY=;
        fh=RX5uWoDLbJdvl6FljyIz+Yt5Vlu375F44IxMt5q4TC4=;
        b=Iar4to2P1VWwPStTvU0gs0+lZNJ+2Jj7IuwY/8RqKvU4DuKxjO1iV/6l31QJc3bCPY
         vVDKJt+tTm65un44skKLVR0IKfkBlLIS4HsfvCwzV1h8YvCBde76P1zsR9FjHhsRJloK
         dakgNqhkl+yMw/6HpXsR8NPP33RsoqrwDwOl9UphzjJGlT6UBKxAttNfEZI0USFTwYB5
         xUG0sHIJzlZ1u6hftZPcNPwP0lWiaI+22m4onchKcTi3HZAkZgtrkwQCYV/xDPT8jbZO
         3jgbHVtXoO53FI1qBlwkZcrTyKDHN9H6Q6Qcm6pdGM184l6BhzhtCDvC+Yei+VG/uHeF
         b9+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784922583; x=1785527383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dKM0STJQOyPUjuFn6Oi7Cy9zywLsBDO5Ren1ON3nbXY=;
        b=InHP36bsBMA+72YzwK+bcHPYX5O42RrhLIhIqCl3xpxSJYkdKyqEd7PiK9DkCLdX0b
         aBbIDT+r1YeXoO2IE2vrwzX4DYhUqvqMtfLn503Re7+K/e+g1EYa0U6+y/Q5kf/qeILm
         UPYmXcVHU63FybXHcTHFVKaxAg5fNNCjNiY+dZshm/zLC1o306EBG+nvedxPnvNrK9qt
         jyVl+BXwWRb8uUq+O7sAequAq8t2sIcqj/4tRoATKpPIwNfil7ZQun0hLa0+YAJuhpV4
         N5Klz4LDAHyHyXyGFAMl3AOhpX6Xr/bOEWTAlV+xfAGMvafY3Vvcorby6lldGXAq/QNA
         9+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784922583; x=1785527383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKM0STJQOyPUjuFn6Oi7Cy9zywLsBDO5Ren1ON3nbXY=;
        b=P6lzhHW1SccuYTH2N7LCalpmSXTBo6cnf1HhTXx6+OjKDz+P/APaMbGH3YaI1HI2GF
         4LpUbWYvy8qukMSJc9U5ZJhtugNanRewErwWFr8GSWcFO8QLaErO6nYgS3wmTpsFevSg
         B37uCmzwyhSbl7adRPBSLkjDc/XjI6ODH1/FiLosBqSJocrreeKN4NXW2yVpiZi/OUJP
         z/WkjlaXIOPoV8cYmr7PIR+p83vKh1VwTlDidJycVAvP0rquDlzrv3qlDIFotWJ2Vh4y
         cEBu5/nW1PWlZ0rJ5xYfQ2mcZ+5syLBW+e/omvffms5wASe4hEuUU3vDVaNJjRq/Ovz+
         jgEw==
X-Forwarded-Encrypted: i=1; AHgh+Rpmshto3R5hXkEcUzGdDP1XTsXKI9D9Aj27P36qMyEBPUecrZoDoNfekixo6EqBuXo7GGz3cFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUo1cLjfuFLKUlbX1GZpVyVOklta3KqcuaLkEGCSXz7tVhPvE
	0hpegSISgmz7MGIeiyU1KVkbrKXPCklpOamnrUXyhVaY7AYVBK6A1Nfkh9oVlAmBVncXAvWMico
	WVHAC/Gye+hcfqX8h8OasLth58VdOkCs=
X-Gm-Gg: AR+sD13KwibwEzhKIrwbg9+vgoifbJy/YJJ7xB+2Q+9lV8MH0Gy3XoUiK4QMrUCmbiy
	1mvcq7uPLqjZK46Ksi6diM2b6l9qffHjocxpX7Tlcydj3HSzUtXtMIi04Vbmj7DiW3CxhloDxpc
	89uMNGnfcUVEdnCNM1GOqmnNY9AUQnw9bACG2O2/5YspYRjzkE1DwPV/FQ+H81C6qEwo4wZsJVG
	fH1LAgL/80xhTw5nHJU2q6t/d7Jyjg11jh6UiobIDsJVUwSLn1lxiTc/AZjLxoew+12qYmmyuNf
	HFqd1C9BqWq1jqi4wGtNZfIl6h0yJDfrWr5vm8mjEcgo
X-Received: by 2002:a05:6000:46d3:b0:47f:8f5d:182 with SMTP id
 ffacd0b85a97d-47f8f5d0429mr6214933f8f.61.1784922582582; Fri, 24 Jul 2026
 12:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch> <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch> <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch> <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch> <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch> <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
 <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
 <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us> <SN7PR11MB81091D62922BAC1AF7A553ECFFF82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <SN7PR11MB810996F17CD8513F4CD57371FFCF2@SN7PR11MB8109.namprd11.prod.outlook.com>
In-Reply-To: <SN7PR11MB810996F17CD8513F4CD57371FFCF2@SN7PR11MB8109.namprd11.prod.outlook.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 24 Jul 2026 12:49:05 -0700
X-Gm-Features: AUfX_myEmBeVSj6zRL0vACjJwqpkSfuNAyqz6ipF0_pSemiO6ilC81Nn2MeONsM
Message-ID: <CAKgT0Ucz8FT0EvdUMm=dUS-Q171ZuT-i-n+mahJV3OvQnOMkyw@mail.gmail.com>
Subject: Re: Ethtool : PRBS feature
To: "Das, Shubham" <shubham.das@intel.com>
Cc: Lee Trager <lee@trager.us>, "Srinivasan, Vijay" <vijay.srinivasan@intel.com>, 
	Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>, 
	"D H, Siddaraju" <siddaraju.dh@intel.com>, 
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>, 
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>, 
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:26=E2=80=AFAM Das, Shubham <shubham.das@intel.com=
> wrote:
>
> Thanks, Maxime, for summarizing the PRBS discussion from Netdev conferenc=
e.
>
> Based on the discussion, I'd like to propose the following changes to
> the current PRBS proposal. Add a new command:
>
> ethtool --interface-capabilities
>
> This command would expose the interface hardware layout and enumerate all
> available functional blocks, including their layer, block ID, and support=
ed hardware
> capabilities such as loopback, PRBS generation/checking, BERT, error inje=
ction,
> and other test operations.
>
> The interface layout is summarized below.
> +------------------------------------------------------------------------=
-------------------------------------------------------------+
> |Block        Name                  Component       Sublayer       Depth =
         Loopback                 PRBS                 |
> |------------------------------------------------------------------------=
------------------------------------------------------------ |
> |1            host-mac                    MAC                  RS        =
          0             Local, Remote              N/A                 |
> |2            host-pcs                      PHY                  PCS     =
            0             Local, Remote              N/A                 |
> |3            host-pma                    PHY                  PMA       =
        0             Local, Remote     prbs7-31, ssprq     |
> |4            host-pmd                    PHY                  PMD       =
        0             Local, Remote              N/A                |
> |5            ext-phy-host-pcs        PHY                  PCS           =
      0             Local, Remote              N/A                |
> |6            ext-phy-host-pma      PHY                  PMA             =
  0             Local, Remote      prbs7-31, ssprq   |
> |7            ext-phy-line-pcs         PHY                  PCS          =
       1             Local, Remote               N/A               |
> |8            ext-phy-line-pma       PHY                  PMA            =
   1             Local, Remote      prbs7-31, ssprq   |
> |9            ext-pma                       Retimer           PMA        =
       0             Local, Remote     prbs7-31, ssprq    |
> |10          module-host              MODULE         PMA                0=
             Local, Remote     prbs7-31, ssprq    |
> |11          module-line                MODULE         PMA               =
1             Local, Remote      prbs7-31, ssprq   |
> +------------------------------------------------------------------------=
------------------------------------------------------------+

How does this deal with lanes or cases where you have multiple PHYs in
parallel such as the DSA setups?

> The block ID would be used as the target identifier for --phy-test and
> loopback set/get commands. Based on the block ID, the driver can identify
> the corresponding functional block and perform the requested operation.
>
> Host-side information can be populated by the driver based on
> the hardware design. External PHY information can be obtained via phylink=
,
> and module-related information can be retrieved over the I2C interface.
>
> The updated proposal is provided below for review and comments.
>

...

> +    name: phy-test-pattern
> +    enum-name: phy-test-pattern
> +    type: enum
> +    name-prefix: phy-test-pattern-
> +    doc: PRBS and other PHY test patterns
> +    entries:
> +      - off
> +      - prbs7
> +      - prbs9
> +      - prbs11
> +      - prbs13
> +      - prbs15
> +      - prbs23
> +      - prbs31
> +      - ssprq
> +      - prbs13q
> +      - prbs31q
> +      - square_nrz
> +      - square_pam4 (JP03A - IEEE Std. 802.3-2022 94.2.9.1)
> +      - tx_linearity (LIN - IEEE Std. 802.3-2022 94.2.9.4)
> +      - scrambled_idle
> +      - k28_5
> +      - k28_7

These test patterns are going to be the biggest problem with this
approach. I almost wonder if we shouldn't look at having essentially 2
sets. One for the standard prbs values, and then one set of strings
that work sort of like the private flags where you can just specify
your own string to identify it and add it as a one-off until it can
become standardized.
