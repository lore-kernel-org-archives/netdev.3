Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B93B3BE7
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714579; cv=none; b=XkEV0wAvlPvOl5TMSRBuSKX9okzXh2aVa/BWFLLFk9cREGnDYQgxIVQG03+evclXjqq0W61zth+/xjSN51JiJo8WR0dG9l4zr00D92m5/pmGXFREiC1WQsHJprbKrnFwRxaJsctKJFIp/YjP0XrMkVcOrVv2H/Pet5AENFmIdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714579; c=relaxed/simple;
	bh=nhrOTQyh7UMtQn++M8YzWCE80xzQyVC8r6SweaDBB30=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ya82+iFQAyQmEBch2An2qUdx5E7XoAzz9RozJIwqEIHvStBWoeFjgH9vdKojqEGrt0e/t8tZk4oc9wJeNPSMnirOSlGqytahsamoJ7UFs1w6g8+PXA9G1s/RnZfbEi0DzAhHP9NFdLdSyac2rM4Qn8EKNvXbEGqZlGnih3hld9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiP6r0mY; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiP6r0mY"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c7127a73dso3443056d50.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788714577; x=1789319377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DnDqiRyDIRazRpP6ROT2Wb0aydA/WE32NiS4KyeFgZU=;
        b=BiP6r0mYUopx2Wk8A73Ezx23pVme8oQ9cJFLOQ9nesQy1OBAdWVeVWf7F3rct7Pcfq
         ugbPsG7rrLrbFC7Kaf84OMVs4NWXFZfyk8UkjubXN7Jkiw1s8a/Sqx3bEXWjHSjXjICS
         10WmzfmE7JwcbcJ1IQQtYjjk/jsr7KMW27v6Bq4KO2kJ72IbzlbF1nAGr9g2XSPlUaE+
         DdfTS6QHFWPMYJLbhvWJMglv5+ayTYHMH9Nm4mGeVT91/2aTvHr0pNQYGi2exXrIz6dW
         qJrpOCOhzVdcTM5SkKjAcznbhIPv9nV89YN9hvChbFz00VJiaHv0CEfk5IxE6EVDOJ0W
         KlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788714577; x=1789319377;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DnDqiRyDIRazRpP6ROT2Wb0aydA/WE32NiS4KyeFgZU=;
        b=WvPinUhaG0ju7GTsNocSBvZ1s6ivXbx17St0KL/eX5+uabK/VmccZi7PY/QTBCWJc3
         QA3AT/0uta1eWbHWdR64gngmEWiX2SihZKR8irl4Qf8w1B/Dbb0w3beQwzsMudvw8UUi
         1Eqwz4oiK3xk2bpNMbxWM1qnOfzZlio1GWU4cswcUlgsHlLwyVFmeYBYWPm7rX5TL64+
         qPr1S9Ko3ucNl65vqsjle9b13Ihzw5l7yojvYTLn7zcKxSLQ6w1FekaZgPuNQM0QsyWa
         XGRT6BbOFUAIexkasyjEw++fWDKFjFlTfuRvR0krqYyYIhl/R92BJcb5mUe6N1lkeNtU
         iX6g==
X-Gm-Message-State: AFuF++k+kKhapdUYAj3vYHfOigaM5JGJMNjoXqMSW1ZThvRNOnFLlAyj
	/QLbNM8/z6KJ8D9yeEXtwJMTXFrvtoGzXtunkLncrtlB9vbMui4nHcOD
X-Gm-Gg: AYBFou0gdgkbdJQWfOc1BbGMkj8SKKgsfLK9msx+wSQifrTO1m0FkPfGNexq/XenA5i
	x5x7l4M9bFORx2epHcymtzOYR4Zf/fILl17q6UGMAAIZ98C3EctLm6Y+FJUK3Eeg4AMbcXN/rJ0
	t5zXKn41F+Vee0eIMVDR201MhFrsSfTj2g0I4dDCHLXsV1b/5Ff8LmlGGqNcPs/prZexDaDPso+
	sETunDiS28M9ascSLUieycZ+VdxoSsLJPcpwt94kooCoogXi1iYCd6Va28q+WXopLDaMy9FSjXP
	qktIO0eKZb+MtxlbuZyWPM2vB911xpeb5tHtXD7gUUD06A+frSxP6eWDpYBu+42VEocsZKj3+zq
	InIMRdywTAyRJK8AxFycdQ64HZnl6gFs+8eUnunqnSeF1TFCW3Hrf0AWbn07QYrJWScOMpNOqZh
	+T9SItdQThMmCcy4MshaT7pf6mcx6QzfuCMjK8W1kyXdQpee4HT8g06tTisnShwTYKpZ/W5PSQd
	4QiBZ4avwdgNzIEVcbV3u3wTAdbZzuLgb0/zLo1hQ==
X-Received: by 2002:a53:bf12:0:b0:66f:c1be:84e0 with SMTP id 956f58d0204a3-66fc1be870amr2769319d50.78.1788714577274;
        Sun, 06 Sep 2026 10:09:37 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48f1646sm6679692d50.9.2026.09.06.10.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:09:35 -0700 (PDT)
Date: Sun, 06 Sep 2026 13:09:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.6b59f4fe2f7f@gmail.com>
In-Reply-To: <20260903-psp-prep-v1-4-d47e9c4c375d@gmail.com>
References: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
 <20260903-psp-prep-v1-4-d47e9c4c375d@gmail.com>
Subject: Re: [PATCH net-next 4/4] netdevsim: psp: drop tx key ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> netdevsim has no SADB. The usage of psp_assoc_drv_data() was always
> obsolete given psp_validate_xmit(), so we can remove nsim_assoc_add()
> and nsim_assoc_del(). netdevsim::assoc_cnt can also be removed. PSP core
> can track the balance of tx_key_add vs tx_key_del calls in a future
> change.
> 
> Delete psp_assoc_drv_data() because there are no more callers left in
> the tree. mlx5 accesses pas->drv_data directly.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
