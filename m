Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6D430CE5
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580372; cv=none; b=UhC8Fs+DNFozSTzdx1HaoUm3zQlKtmZAAGKP2uM1ICOTBPl46kIHkIxfc1jCfDEo3Jc8BCelRZ20Qzke+p4zfuCfhie8NpJgf1zNl8TyIKPw1xMFY04Sl2f/eb9qIouGrXY2WsizKXrkLLFhil6CjRh+OHEQN4hFBxR96WptNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580372; c=relaxed/simple;
	bh=CeSCG++KY9gfAuTkjwpaZQ7t1nE80ziKBJ/jFMAB/TQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mIVsswxYb8vAh0IcYkWp/S70YllUhowNcPHNtDAvIRUP4p+W1YfR5sQz2yHzTRrXPSYSw4fUEm5wNuuzRQ/zZHlPH2SW60bGtTPh4cixnqvaDy1Qg7R27UH8rMp69roj1xTaCE3C/2kS9vXwp9iWP2quxIOOAYGcy2sm5ScPb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqwHIK5y; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqwHIK5y"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836eac5682bso62586917b3.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 07:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787580370; x=1788185170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u4t42PIG6VatROh4/IYP2MRikf2/Iy6L8DlGfCTlJyg=;
        b=NqwHIK5yX46u5XBYKXjoKIrW4SBjobrGkuHMZtlqRJwLb95NTFHf1Cb6qRZEOhP+7q
         huqHBC0aoN1lQJeR6UBtyUl/mEPexwH/7KJMlky4Hki0N5ds3nt6+4z6UnpO67FU3YyP
         Kl+06ThVShRkqJqmoG8QhMostQ52/3qqTDw5OjKQCVsYefVlWKIEHU20XQjmPdL7ZEaG
         dGoaXw6MVbWQj8vYAh/FBwm5L/txLPS+uiao7YfzLgquw6DmMuXt4cHgL8pRY+NIDtH+
         24gBY8EOOaSdz55poXlg63BhjOp6usF5KuwZoo9hgQxOrDTHkFoglCtrv5+3D27ruWmn
         QMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580370; x=1788185170;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u4t42PIG6VatROh4/IYP2MRikf2/Iy6L8DlGfCTlJyg=;
        b=JEwCQu8PspQrXo1o2dibfszv/efNq6r7BNzPNjeorbZg0GRigBgE+AyB6kCGVSCbfa
         R96khjWCC/CXGFqn5t2z8gh1ODECtLXVYT23Px1K1xXgFpqJ1J6B6PJwUqM1VD6hItS8
         PCQXX1qnLqWBMUWO12FQ9rq7jncygg7ploklOF6eRJJKtFVoKPQQPek1X49WnuCUKGT8
         a/3RSdpBzMhZTPLpYWk9zwRXDdAVm2D4q2Cj3yjYtOjfX9z8jAiAp137SareARfrQOvV
         fQlaDizpAihsMH+6aFn6mByTLxaAfbJaHM1hciPupG2Ed9xTrg0N4QIL0XAS0SNXGxBF
         pXnw==
X-Forwarded-Encrypted: i=1; AHgh+RpRWJl+RqY16hUCsCTYF/OIbfc/AL+a6fwpipkkzWpFdricsLUw6aGm2MeoHQE+BIcBJo7lBIY=@vger.kernel.org
X-Gm-Message-State: AFuF++mqs63UERfWWuLyfu5IUuUd/s+QkFOB/NQM0joDOgM9a5DS/ybG
	ttxtjhfhYwFTR/v3bzIjyxWpmW1urXR2HpM0DeA9+HzAHNLF9kAcFC5wwsMSqA==
X-Gm-Gg: AR+sD13B818er7L5W9qPmzhVPX0hyQg3c+n9wjS7B5UvMYD0NuyP1ZQLSiabX+IRXYp
	3+Q/jIVRwSk6eTTr77UJNx0eloO5RN7USt68g4HLkZW2+P5H5RgK6Sn6VsezM0Kmmmd02jfF93H
	a2wyKTTiZMXP4wjzKcl+OMaIyNwp3t7in4iJcBoPkV8g4y8J9BwmnHosLcYuoCtQ0Bw8wBEyp0r
	oDtzDC4BD9GtTqWti+7myILeqepQwIdgIwsSruWZMGLnEpw+Pus+mBJ/gLPT714i5aCwa7Ovls0
	39rPExkBHi7DQ8cTHmAyieBdqP8T6WYjTG1aVDvKgUwbGkOqI8pyWoD6ugVI9Ity2LriTloGpHU
	mrX4DzZQg3m1Xx6RqfWR1YnCQoKnUMpSwQkybGhmnE5sYWc9PMZYhqEHSz38qKd/fE9pZBZ3HZt
	Ck0KwlXFQphdrK3XdMu7POBwiLYeWPFs2qKtiFdGAq5bhmDJii1bQmlMejRH6kGA2oiVEMtHO/F
	ceRO4CXm1hnOwzIA326ks7xbebWA3xCTR4+vWUGKQ==
X-Received: by 2002:a05:690c:b96:b0:82d:8dc0:9cf with SMTP id 00721157ae682-8470c1665aemr143190037b3.13.1787580369575;
        Mon, 24 Aug 2026 07:06:09 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca518898fsm34038707b3.7.2026.08.24.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:06:08 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:06:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: JR Lanteigne <root@dnim.dev>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>
Message-ID: <willemdebruijn.kernel.1e07ba16c4cf4@gmail.com>
In-Reply-To: <178756707212.4073008.8425791726071449399@dnim.dev>
References: <178746246095.3786864.2262454553798466512@dnim.dev>
 <aov5lCT4P_3tmRqR@localhost>
 <178756707212.4073008.8425791726071449399@dnim.dev>
Subject: Re: [PATCH net] net: fall back to skb_iif for the timestamping
 pktinfo if_index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

JR Lanteigne wrote:
> Miroslav Lichvar wrote:
> > That would cause applications to receive a wrong index in some cases,
> > right? If it's possible, it should report the index of the physical
> > interface, but it should not be guessing.
> 
> Right: with the fallback a nonzero if_index is no longer guaranteed
> to be the physical timestamping device. An application that maps the
> index to a PHC without validating it could see the aggregating
> device where it previously saw 0.
> 
> Reporting the physical interface does not look implementable in the
> two failing cases. Without CONFIG_NET_RX_BUSY_POLL there is no napi
> id recorded at all. For cpsw the napi belongs to a DMA channel
> shared by both ports, so there is no per-napi net_device to attach;
> the delivering port is only known per packet, and there skb->dev is
> set correctly, so skb_iif is exactly the physical interface. The
> index only becomes an aggregate with bonding or bridging on top,
> where the napi lookup would have failed anyway.
> 
> So the choice for these packets is between 0 and the skb_iif value,
> which is what IP_PKTINFO already reports. No objection from me if
> this is dropped; I can respin if there is a form of the fallback
> worth keeping.

It may be possible to detect whether an skb_iif points to a physical
or aggregate device (e.g., through lower_dev)? If so, then the value
can still be used in most cases.


