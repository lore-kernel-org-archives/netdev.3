Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD63002D8
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785100039; cv=none; b=B+gcX0xfGW3ur3kHQyvs3DOUyN/hDNBJBjcbptbYwNuBdrmahN7se3pnmQZMK3Kc8A4Lu9yPVAsJRDfnaZRhRCPRkbdM6yV9BeEk5L0fqv+yIr+m+Wr5DoXUEqkrI2erLH14+yQXuCFcsJ6yPIzPXcVSsCr3lEG7zxCRi8HaUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785100039; c=relaxed/simple;
	bh=5Blq3TYbu4fTreeizYGU8/FUXLJ6fs8Bh9P8XQ/H5MY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rpQGnPT/I5E+BZsmoOn5bM9Y50GlWGdqulClOvNMUnOmisxFNVEfsEZNlpxY3m+KcE9N1hP7yBEK17NnvM3VLOhqpc0WHMdBFfPl+8h1QnWaGOD7ZRa5kwjyo9oJoDebZG8AVUIz2JfMZGYJaDHwuOGrUnofHocee3tq0UuOhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkpvY+9u; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkpvY+9u"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e6f2ee60bso28025497b3.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785100037; x=1785704837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sNSW8f8FOoK7NdDfq+v/AsGScXAA8FLObBftPbD3K8Y=;
        b=dkpvY+9uJSt3q2vAFbZ5c1xBRpVk7UEtC1X4x5Oo/p2eWXCkcZCY2HxyyMwWtzWDM1
         +ZZeqHkOZLD3bIaVWHmUY8536DDBOHwQlkJwasYmu6rr6Uc8yN1dOMx250imyh0t9hnF
         T8HK34H6izqXIvQLaDEhqzyLb7l7xRqB20dtxxnsqXQlSgfQl9+cduyPgLJ4K4/VON7K
         RqHpRUb7lXNWpphK/ray8HfCg54Vm0DWpk7OrnnJPS6O/8Ka1YdKF4p8we8ma4nUAel9
         Xe8+DP8D7Mk2R/pCPfB/CLPKqEnXfV0clq+6kOIKGHQ3eVNZPRWypC+ip/oxblhAyFZV
         od3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785100037; x=1785704837;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNSW8f8FOoK7NdDfq+v/AsGScXAA8FLObBftPbD3K8Y=;
        b=blkqzwpfMwRHLo9f3dkpBmW5tGrkB6pMor8n6yc6r8fWdLH0a6Qh6EPN6zG+FAxi2O
         PtfEbXX6VAw4E/FximkGgLbrD0CPVxGwKPcH2OZP2Yec6WFDX9pjdwqD8m+iDi/6bZzz
         EMAAVi0mKN/un1wL8DmUQI/t5apW+FzZto3/YLlLcvhXUPwadHR2drI8TeBYfRRBYiZz
         JExjQqBdczDlRs2jkiRZ82/qnGdMWajX7RjHPhFzIHQ9IwXUuu20uwOTNm+jLsM5n8Oj
         vD86RXUUcTLmhGWkVuDk4TXTbSdPIzFyK1/47Asn2kMCpO0CU3S9US3stvVWtf0j23c5
         1hHg==
X-Forwarded-Encrypted: i=1; AHgh+Rpcn5KSmUrl5g6pW/YxiOMsMTys0Tj2n8l4XcKpHSApE78z0r7VzlHNPx2WxtExO6XYfMjBnNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00SHMyP87C9KwgPeaAYp5OhTjSQEjEqFzx8G+Zf8tsACJqyhk
	YPkyKCYDP+ug0iiUNz9I1a5Lq1u6WCM3NeMqc8z3ZtVAmRWjl7GZuwHj
X-Gm-Gg: AR+sD11m5wJQt8QTSi58H8BmNOJ2x90isMR7sxSeKw5utBJilqE7wQRoufoEjjlbPPq
	w9pIL0epLuYrNcyDoFVdkgZHFh76xdzCqMuyxtNkQ6+W1cvlGomzxlTSnSsQGTPTckZjlK7T5Cf
	mHG86t56janKyPORAex/xI7U4kq6IDsaLv114BLY8rKdONzgjoM9HlfPQXOex+oVDUwwYk/b6E5
	qZ0dTlJWEUtGp4H0aNBSBNTC/byOMVQvDlPcPYrpS19yum8GBNubSQMJbB+uROXqrJJhEDF19sR
	HqnjXiHILfk62eksqLbgLbQeaGVbdJ1GbZpbN7824kyhSHCiMHUSQLNS0/ZL5CXD6EOi6hpmnae
	5zxC/X60P4rqb15/qQdvVP6wuN9YmtDTN5ysy1kW2t/LXBt7CRHi0CZujrYP3oB4k7iDXuiySZD
	bjA7DZ9MNT4TEPfeIu/pDvGObnT8GqHdB9FLvUgJxw7p8U4679bg==
X-Received: by 2002:a05:690c:a87:b0:81d:455b:5fdc with SMTP id 00721157ae682-81f6a7a831cmr16868727b3.28.1785100037525;
        Sun, 26 Jul 2026 14:07:17 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f655acc7csm23588037b3.0.2026.07.26.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 14:07:17 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:07:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.234db41b2fe04@gmail.com>
In-Reply-To: <c55b6309-10ce-4074-a70f-64f58af2591b@gmail.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
 <20260722204454.3234605-2-willemdebruijn.kernel@gmail.com>
 <9c0a0bb5-737b-41b7-828c-1953d885fb1c@gmail.com>
 <willemdebruijn.kernel.9e5ac85b024@gmail.com>
 <c55b6309-10ce-4074-a70f-64f58af2591b@gmail.com>
Subject: Re: [PATCH net-next v2 1/7] net: ethtool: add hardware pacing offload
 support to rings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mohsin Bashir wrote:
> 
> 
> On 7/23/26 2:29 PM, Willem de Bruijn wrote:
> > Mohsin Bashir wrote:
> >>
> >>
> >> On 7/22/26 1:43 PM, Willem de Bruijn wrote:
> >>> From: Willem de Bruijn <willemb@google.com>
> >>>
> >>> Add two ethtool rings operations:
> >>>
> >>> - get pacing offload horizon: active and max
> >>> - set pacing offload horizon: active
> >>>
> >>> Replace u64 max_pacing_offload_horizon with u32 active and max fields.
> >>> This occupies the same original 8 bytes. Reduce precision from nsec to
> >>> usec, which is sufficient.
> >>>
> >>> Update the FQ scheduler to test against the active limit instead of
> >>> max. It is the administrator responsibility to set the active limit
> >>> before installing FQ.
> >>>
> >>> Assisted-by: Gemini:gemini-3
> >>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> >>>
> >>
> >> If I understand it correctly, the horizon lives in dev and is read at Tx
> >> time, so it shouldn't require touching ring config. But some drivers
> >> reallocate rings unconditionally in set_ringparam. Can we highlight
> >> somewhere (maybe in commit message) that a horizon-only change is meant
> >> to be non-disruptive? I may be missing the underlying reason though.
> > 
> > What do you mean by underlying reason?
> > 
> 
> So I meant, beyond just exposing the horizon through ethtool, if there 
> is no reason to touch ring config while updating horizon, a note about 
> it being non-disruptive would help.

I added a comment to this effect in v3. Hope I captured what you meant.
