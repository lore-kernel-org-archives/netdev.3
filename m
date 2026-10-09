Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5963911A8
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562233; cv=pass; b=YHeLyPoBTKaZ1DhQmUc5CbwLv6VqWxbQBuoEXt3yox6efWUOIHIV1At/l0HcC4HzvKtc4LBvBpuf7l46aJYUrdHuLkkYrFcgexHu8iiFtkYMjkzRKJGXpQCSzfCPQQp5zXgMhz7bEn189SQu/t/tFxBtgyDMq89sM5BhXgE5Yk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562233; c=relaxed/simple;
	bh=l/2NvT8wAaZjhTPr/ZhLk8DKnV44dtAlDJhAZmm/nMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6iUU1S5jFvnCJ5TyXNHo66o1BTUIs9LVe0l/kKTR9pgXhMxzMeV9JMiB1TzgJPuEPsHacmBq0xcoNZSL+foZkHJUpSY0xr/7aWLrZYP81d5W92sE34MkQu/0gg6zONXTbWMfh27RUu2r06v+WPkx0D66F8LKlpqqSmtieFSOaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnnKx1YM; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnnKx1YM"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso13108a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791562231; cv=none;
        d=google.com; s=arc-20260327;
        b=OW6Yp7gvhf1W9DyixGg0lr0JGD5DIKW+sETzd4wqhkHrVOs+zPaNvfqcJeIWLHV5xv
         zVrZJnJkumkMwhOgo3olK08t27Zys0+DswuBwkzE/wISXHSQesJVDaK6uuKAVns3iDLM
         ay2M0/E2ZxG2ZMMNwzq74XizQ7UqvTvJU1QS7jdcyj8tm0/SZYCiXsjsi6x4MsJqge7z
         E3/ChwaLvCUVzjmossifNuCwh3ivrZmBcjZQAg3/d7L4AHu9zXd13xRwJimyrN1Hlj5r
         v8cU+meORiipz7fdos58ghds8lXWc3rj+CAVAzQsIDOWrmfqRnhAfJdTmefYoibVb/H+
         JaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Shr7ewCDcxmR41j8pJezsmsxST+IY4eGTxrK4PfmAFg=;
        fh=8DQdmzgxcJyADvnbGjpxzBE4Vx6szGYRrUAgU5SWJxw=;
        b=fuajHpvJme9NPd2AHOAz1V2/VuLB65VwNPO3WSv0c/BH82N3zeinIDn5swYEAPeqUB
         IShAu6CJfrf3QaEHHoiZ9RB+1sMi8pCWm80VwwCuohfV0CWMO4sa4+34oZKe/GG/iwjL
         NzKhR1BB80xQhRDyXt6a7+tknJxjInUH/z4sQF1fkon06OX7H/itYaO22O5dlcMHxzEk
         K4eI6E+kIa0iFTBSLakhR/YWKFyqG5iwwfMrQvbjdJzcJflfZPpyO1aqUlzu1taFMi+5
         b2UBQSXsrXbuwG8aMsWgrjavaUzBeZ0J4WneAZTQVY5dmu7oJPwP27di3fdG3iohWgva
         8GzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791562231; x=1792167031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Shr7ewCDcxmR41j8pJezsmsxST+IY4eGTxrK4PfmAFg=;
        b=rnnKx1YMGVv6LcMJI3ni0RBJ05j7UP7eLxF05QYbTCPY68PYu3RkbGwhfVwUP+tUvT
         J4ENfjUQ+uk/qDOkoVAJRD8pZE2r8wnE6egJBWtXyph5GL0iP8hfeePVnoFehAnNRdB0
         83CR/klE+scGAMTSJlNxV/ChReMXOFomQoKlcsYhypiSR+BxJkNYpJokIhlvnF8sKqzT
         W1bJIvvgQwgYo0pL82adLeuASsykp1cSogmisXOR0bmlzYhI7hi0X4jzXflkmGCCz8VK
         Ox+0lh3rObmzoGPJ+0S745nRmAvA+cGeEHIj3FGU0ayWU4H11nyBan1Boky+fZf6/s0/
         ReXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562231; x=1792167031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Shr7ewCDcxmR41j8pJezsmsxST+IY4eGTxrK4PfmAFg=;
        b=oACmtGV9tNVlWz9Ozj10+LoUG5pKXmtYHZGpnp5S1A/7CeI2dFxP2qEgsr3k0sjLd4
         wVurkbL4NOlVfZnLPd9A1zNkD90kIc7hKh27zvxnTJH9PmP8k0Yc1H5t76R4sOK3417b
         Bgx2g1B/zRYT7AhgeXt0M6nB4+Ismr+l/SpO3z4NoaoPxDhEPR+xSaVKmXHMF0NYudGY
         Wx5i4+pQv/a8pwWEAPwE9+Mjmt+w5N25JvZSYeNHpQDkFi8zpVnWYhbtWGrpBTWRBatM
         kTb+hFhwtvR5EIdU7xmCnLjkBzCeDcKNOcHfqMdW4yIbdLk6KIsi/8x9weCePBmJSBS8
         gIPw==
X-Forwarded-Encrypted: i=1; AKwUvBwlY9UhfR0j/l9uPfCRaCpwjL3cDKT/mFQNKztyAumzEpOR2mStqVGXxgG/G6W/9ebDICWT7Ek=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRb8wkBPj+xldAytxWBCv0j8KQchaZ3wytvkow/BtgAPG4yxcM
	2RpUlzbR34cZVWC/L7zSnuwDQT2fipLGuaJpSgrgWrTfzbExdW089UfTZBuKYr2mtS4Sobljdyj
	GQr1rapgmUAVH6BRSfkNCQM5CSD5xNWJLvTcCgUQ9
X-Gm-Gg: AYBFou0WTB8lHmUIBOZv97nDQur73tGQjmUOdFxCQUjSIE8aDT4/iQbe/8vGwUaehLU
	9U4TYGSAcd+RLJb1vo+Qx9kARHeK5DeGQdzvSEFNuzLjPYThsPZB9nU0GSXLfCrbdRBdw1kjxu2
	/e/7X4XhIZt9CD9ajgnAlvObiCmwSt4DyUGpeexRxqB5snJkX/eZzff5xG/LqpQ82E5bSU9j5oC
	ix/nd0irYixnIyqsTN1o5fq8Wvyf5iUTe0lrWByXOBAn47Hj8pRmZLAbAUitmb+QBp69AZkrwlR
	5JkjtSbFZgUH8BbBjnNFjcZ8bN+nZnDPatXc6sAM38RniQ6FdwintA==
X-Received: by 2002:aa7:d743:0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b17b963117mr42270a12.15.1791562230138; Fri, 09 Oct 2026
 09:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com> <20261006-b4-skbuff-bug-on-v1-3-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-3-1b4434c5357c@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Oct 2026 09:10:18 -0700
X-Gm-Features: AclHuK--6z6-8oIyC9Y_LYzNmkmzq3sx298S05qv9PBQ53pFLOBymcY5H1fz2x8
Message-ID: <CAHS8izMK_RDcYBZq3AZEDcxnRHWRt3ctOkPMvoA40XUmCs7swQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/9] net: skbuff: don't BUG() on a bad frag_list
 layout in skb_segment()
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 10:10=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> skb_segment()'s frag_list walk assumes the GRO-shaped layout it expects
> and BUG()s when the layout doesn't match.  Anybody who can get a
> malformed GSO skb to a segmentation point gets to crash the box.  Most
> recently commit d5dc1e69fd72 ("inet: frags: strip GSO state from
> fragments before reassembly") fixed one that an unprivileged user could
> trigger with two writes to a tap device in their own user namespace.
> commit 3382a1ed7f77 ("net: fix udp gso skb_segment after pull from
> frag_list") fixed another.
>
> skb_segment() already has an error path for a bad layout: the
> too-many-frags check sets -EINVAL and frees the partial segment list.
> Warn once and take that path for the four layout checks.  The packet
> gets dropped, which is what should happen to a packet we can't segment.
>
> The one check that runs after skb_clone() and before the clone is
> linked into the segment list frees the clone itself.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>
