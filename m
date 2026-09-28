Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC344BA1C8
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597203; cv=pass; b=FHktBUJwku9dS6sOO+A00jHRqe6Fsh+RJSH0aqyBw4EMcgai/j6dHTlRT6bN66Q+tTCRlCsdtoNIjA8bvFVUBYcvUSrX6GbA6eALTvPeZhjF7A11zux0HUnvQzydVJ1sTCaNeE+1JPIvGjDA18Go509FGF+nzM8bcbHlkpWVDpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597203; c=relaxed/simple;
	bh=4evASwW7P7CNOZ4MoQEq5aMRMPrIibSAC6+oJk6cUto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdrlCAx7dhhYtJqCDaLCDBGxOMRFjKhM0gHWZjBgbwNYGODFaxpPdCjM8eb4VKwos5GV+SB8/aLZ3XPRxQN8lFeySeOsAkXLvZ4bvAiV/gllbi4ZYTeFzeso9Is34284Z6rkDDJ1Q7NNrewLe4iDeCyaJMFJUetoR8ZC7tDU3/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMANEXyh; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMANEXyh"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a651f928d9so20625661fa.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597199; cv=none;
        d=google.com; s=arc-20260327;
        b=c6OpWyniM6I4anBwCLTgujdbrGq/ECIjW9YJ0sNqTHS2n1hOAl35eN2z44mg4fryBW
         Ry4p7ylCEyTTxOXRp8+Xss8lJEZqUS7iqzdONYwTn6npd5OpqN5Qh8Wp7f19PQsSB9zg
         dQxVIDuTj0vzMvRDjGzxodoyO7tlFjddPDKkjMzDlVuxhHq68d53aQCFTdyqJEKSzwSF
         ktxqkLPAvZRAY88ZrmVczGRICpgEOPb7VtmZKOM+Nug82pPCKryWvI4yAbzK4C/8vgZZ
         Gj5oPig0rnuMO5ofJBAWawKYVUU515ZGYqgP4eAc5+EUdvlS+6J5VvxSHCE8eNlZjISZ
         tOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RUx7MhWskA2OQjWEx4q5vZ3jkVu4ih/mG02nQL70+Qw=;
        fh=1URiXDE2EkFx8m4V+mMu7NHRC6WU87SkfoI6nDTWwhU=;
        b=gbyG6f9exg552aXM9DrL6xPtUfoIXKvvm33AVIJ46uoQa1RNwS86f8ad1NdCv/ajwq
         Dnfu9acHGBd0WQroNfNAoLAN3QH/zi5tpZjWSrE7BHwogHXusNba0MFAS5txf8L2tTqE
         lCuP16nXuIc6t4yPLfrr0Ax3qdqK4LYlSOAqfA51uvH7oRQX42YvjfE8T1agwTPeWd9a
         AiQGPnBBElG5zuSv8tJy+7wReUf27KCNXpp2wtrWIsQqDagEgDmsI1yMp4f8o+KYl4mT
         +HrLFT5Ockz8LxzyZRE3HoOBV63h/2wWNQmyJJDMnZwmiEJ/zMBEWjPFitsSCnC/JkjX
         r1Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790597199; x=1791201999; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUx7MhWskA2OQjWEx4q5vZ3jkVu4ih/mG02nQL70+Qw=;
        b=iMANEXyhN8X9Fx46yLOc4dsg471HFwvd9drJzsZaLtzROzBYRSL0eRM0t6SiAgugeK
         AmnzA1dSY+NUpWCSQv1W76pQoXwTzWqGDIO4HG9Y5mhyByyhkrimn9KABwKwIvwfTIqf
         VoaveACy9JUMsgqT7mLlroF9Dnu5fDbvNrcZ7W85SuEj6kRV6rZpTXHddey6uLyjDjZa
         y2EqPbD9+gBX868s4E+WPaKsLnSCMOLIVx+6S7cfCMPvuam0viNy/Ab+Av8GLn/HMNr+
         Cgyi7rrU8SZx8tVYZNWs5FMoDFZr8AuEfpY/EOspnKXE6OpZboLGqWpYsRVRMI0F6rdg
         8Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597199; x=1791201999;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RUx7MhWskA2OQjWEx4q5vZ3jkVu4ih/mG02nQL70+Qw=;
        b=zx7bnolTUpzuXfm2xTWKMaiNW4g3QFrH0OW8tp65sJcGozaG61+8n+gBlKvFzQQa4g
         2MFA3cxEprkiKcZ2EdtFq7hMpCMGjcRX2swdj0uz5rM67mitcimaSbvnyzUUDxGb3oGI
         SULfXfRaUMk3UIKpgbB1P3Zja+2REgmwdpIkhX12AiPn6dP7qMJRv1e87uYqSXTiExD1
         jeqfPazW6Zzv/v+Vdk6ihVbx6sVxhTIPbKX8uJy6sqbHtGFTfBVvpKkxnHDMMJZMXCXo
         Tv4XnM9ZGSWhr+7+cYAtVuJuiQisvFkBcmz5Ds0XH97zqnwmaPoPkbT10/d0rBC4JXEg
         v2Ew==
X-Forwarded-Encrypted: i=1; AKwUvByRRHgjydulhDCeaaU74mYBPG5zoxNjus6B0PdxYJn46570exYXI5ag4WJhcFCUwKr3AF9Qjm0=@vger.kernel.org
X-Gm-Message-State: AFq9FYItjrRcc67SHsCqTadBmxxDBDHQmU0J3RFmu2Im2dEwxe2d3yGL
	n40AR6N5+PsmlHcSu044cuHrN9P4zcK7JEGJb8abmEgyqxy3JQnu3Ef1GVVwxM3GeuTond+aGam
	XPe4DeRRfE+ogURo19A/jk1WyAgXJIak=
X-Gm-Gg: AYBFou1sm0vZiZy4uOqBrwxnonLQkTgVpC9qca2mGS1j//xnCNxKZYodoW8qxeLhQna
	vXRlMPMjKOAzpdbAY4bCj/4YjNoOn0bklCWN6TE5Akh3HtSxG08LrYVtLx1gAfXsK44dlM3zBIJ
	gxDcwW3V6Pt0+myIQSi/GnnZ24YUdBXaye8ohWXBFFfeGyuxCSk+34Crc3dmsXwe8XqQoFg8QMo
	iM3uZyFk4hPl8U3jXC8FnI1fh2l/B4kIqbKgT9Tewz3qa8A4INY2rxtT6RU7brXwrh5UAJ6zfbv
	79kaIr4I665CFGNVatn4uiD7jYZvjoLXsQwNMgjbw8gz6z+rVqOByL3Lc7rdUINyUT8fWuaO1xH
	SoXkrPDNKogFwEyZolNmkbWDGP2F59fPbKWmAjXSJTQ==
X-Received: by 2002:a2e:bea3:0:b0:3a6:6590:fe9 with SMTP id
 38308e7fff4ca-3a665901989mr11898161fa.23.1790597199210; Mon, 28 Sep 2026
 05:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927002427.4519-1-sigefriedhyy@gmail.com> <20260927002427.4519-3-sigefriedhyy@gmail.com>
 <cd00e6e7-aa2d-4f98-8a79-083b64b3376a@6wind.com> <f72a5150-4c75-4d71-93a8-8b261ca9762a@6wind.com>
In-Reply-To: <f72a5150-4c75-4d71-93a8-8b261ca9762a@6wind.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Mon, 28 Sep 2026 21:06:32 +0900
X-Gm-Features: AclHuK8vcBPbo8FWQrndniQx12n1nqnhRIJrnPMscvT1DLMWqohrVqCxkvZ-fP0
Message-ID: <CA+7S2v+hDjbJV2akWHtospORWSwkPuLWeDzidUADUq9Mh-Ag_g@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/5] net: add a generation counter for dev->mc changes
To: nicolas.dichtel@6wind.com
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Renaming  struct netdev_hw_addr_list->count to _count would help to check all
> > users and highlight that modifying _count should be done with helpers.
>
> This comment stands.

Thanks for the clarification. I will use the helpers in
__hw_addr_splice() and rename count to _count in v9.
