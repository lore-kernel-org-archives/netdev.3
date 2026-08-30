Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6F03F105B
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788113644; cv=pass; b=noRUjrw/thzmlaa8zaBxiXJ89F15HfEMUf+EtOlMv2rpku8JR5G05ym0R645e+oX0I4FeEEDOiqI8RnH7LujTQFhPEc5qelx3lO5hMxG7maY1o1Ghk1RvJoqBDwPeMfw7YFAhGh1xGjtW5LjOqdDDoSp1NIH1lDAt8z89W5mbck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788113644; c=relaxed/simple;
	bh=HdzWhpqTNOBl+oorJBrdklXOW54bPXg89ysssBhka1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkLt42mb2AKthTMMx4/bCAlFKqs8Ed0JUvdtdSXzxCzYFRu3hZUKOnpLNEDbxFSzmcIX1TqAZdqKJb7TuuCDj1qlH6J0iVaei3Dr9LgITg89c1Y3McsYBdY08rFrNUfY8isnNxJphu3CHSaYkAyLOjPa+PsFEnLnAwv3oavVP/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNoQZ4OG; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNoQZ4OG"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e85499ffbso213262885a.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 11:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788113642; cv=none;
        d=google.com; s=arc-20260327;
        b=QVvFhjXfK6aAFy7tkxRBaNXonZA4Klb8igS5PEWJukzT4J5wU6p0Glu6lxc/pZrcV5
         f4W8KoZsab6XiWEaPKz96q8M6FF69fnVg/tAJMDOmrukuo3Hyi4UhyaGI3S2LGKp0k6k
         oEECXJ5u/gM3alPQWhyStm2T2gZbtB0Mk6PkcHr2MpyDLMkG39j0lfJz1sK8SuLr4djp
         mZ8DL0lrSeMaANpmnvkxV0Gt5Lo4V24wYc/Q8kalMA4npZKc5EG0PC6nTBYEG79Vfc4p
         0g5tL5lDosUleehg5BR4kzvdR+nf15zR6xunslBvs/w32NtvuqZMZmi/PYJMlCa9gWXa
         s5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sAmNPF/JjH9F41LuxYyTcqwhseN26JSfCU5penkd+pY=;
        fh=MYQuwmDCCzhtU1yPuyGoem4qj+Ce5HRjz0gG92RFGJo=;
        b=YUETlpvqOwyJoCjlfhnCAoVUPDfxlDT5fqcQTY3nT/H6wbqdtsVyfwX+DzEWs6SQZT
         R1BQKRXcuX0fmjd2I4GkrosRg4pt8oie7W+xeoyV/Kdg+0ZZ1hEiqVX6XXlaOHJjcomk
         UDnx7pRgHo870wqUZzM9k9xizVB1JvrfkBGtT8MHU1nQu7sQiBl5KdC9fTzX0A33xwHr
         t8SQTsdD4YtE9N+MLsUVZE/M9ZkXHBATgVR7yDJ01edfkrHBNJG6tqQfryDWPRQuoHZX
         lm9+Eu9sCT/A5Hu8FtRQTOv2nZ5qKHiCBuHd3LCATXZTIfJOpOEwCKLSls68UWAYEYaL
         80NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788113642; x=1788718442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAmNPF/JjH9F41LuxYyTcqwhseN26JSfCU5penkd+pY=;
        b=SNoQZ4OGCuiWs3IOfSZkxlKT9kCQ23X5OT2yc81H2RBrxxiKqZmEjDvmVRdyChk/1T
         TSJNaW0NMqJNX+h/f4F3E9ay+HoQGrM77jkcflro/h2mWl5JK95bZCOLHKPcA4n8Jws/
         +4gCsgE0wEo/g4HPIR74c96rz/kO5OWlH9zS6YIlCcMHqPpXba+Yhw1A9CajsRoZRk+X
         KbzGVEBqFSJZw3yHw1HTvLTYBg/mpsQe4KIYUEcj3d5MLeZ6qVNbdNf02pON0r45XL4Z
         MCuvQfOH1zHwoqiS08xBPOppTyLx/wMTGLkvsKqbbSYg7hhtf79AJ24Ax06X5LdNDgl9
         R/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788113642; x=1788718442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAmNPF/JjH9F41LuxYyTcqwhseN26JSfCU5penkd+pY=;
        b=hqXFy41/DUHs4Q4rvRzuyJMCnP7toS9hCRRzG2T7SaYTiRzlqSwe7S1q4NqfwKd6z1
         Q8sp0B1r6YtLsqjDwymIipYyKKKwEGDE6tIImK8kv+RUYQHD8Q10nfoFiE8JfhLBIPfY
         P1LzbARsRCLSHos2lMZgYTEBbbvKD9YGKl086fuaVkZaeokDoZBRhqVPsHQrpCjuWV+E
         diPLwKv0ZCsnFn+tshutTGIymfymstURF4V/4ogAzNMnfOJoDl+w6Yg09um57YWtg2ZA
         dUJjs2jlNvI897eDXAevS2R4tpDHcneJMMtxloFD7wyg7c98vtLJ9ad45MCl7tgZqGrE
         oHKg==
X-Forwarded-Encrypted: i=1; AHgh+RrbSRBk0oynKYGjpJkuOlH+DWBCAyWXRD+nvOL93I6RAxgtjuXu7ZTa8kSJdDTxWOmbNFZlvGE=@vger.kernel.org
X-Gm-Message-State: AFuF++n6/+yXZbsbUFWb9XPgK3mQTaCksbqVvPzNNYwMbOczcrqHvkjr
	Eic9DuNp6lo0J6YIXl7We56kzAeCQRUsaQakVBiBjiuUW38lszA8+KYLf25dMCx6UEeOVVxJ9NN
	99z3rFUlfMNgs0SmwlAoVIPbxQXfrwmDD2uUut2yz
X-Gm-Gg: AR+sD10Q1g10WyrOjy3TxUE0t/Rm/TuG+2oBEXGFyF2YCNbglNOwGgL6EV8Wp+ke3hw
	J8z1lH95QKoWZaiIfLyz/AEyuXtbJsKmRnxNL+lM6CEi2j87Ts0ASgjYFmwpOvd0f58aybVpDhq
	qjmZn/YtTZnzSBpBhEkpQzzH8UcWR/U6e0cDfs0aBJ5Zl+6Cb/T1FM5DBpdY3gT2XnmffeoTTNo
	6GS+dWfIpA/LsOshXgqOwr7Czv6c+W3wTjkJDM8m4DcXQtx/3aCOnxFNHR90+oCO/bTTjhT7M3n
	vNtGMOMT4TJsLXSHBac5vysRsk6FEw7mzYppgXmaWhLHba1DM4VzxC8VXMBmVIUkzJVsJiOQ1no
	zpmrOfETBrLVh0LNrhJx+J+sohLV7AexlFGMuQdR6K5Nfk0fPeCcfBGk8WeY=
X-Received: by 2002:a05:620a:4553:b0:934:970a:beb2 with SMTP id
 af79cd13be357-93913904111mr2296320885a.26.1788113641282; Sun, 30 Aug 2026
 11:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830151617.3546585-1-den@valinux.co.jp>
In-Reply-To: <20260830151617.3546585-1-den@valinux.co.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 30 Aug 2026 20:13:49 +0200
X-Gm-Features: AcwNN1V16jcKxWw-kvVgE7bYpkcZejTegRvsFb9cvbrFA76wK31yO_UJFO7y4ic
Message-ID: <CANn89iLWSa-4_Agcpmt61FEV=X7YY42nLzW9OLv8=aWycF01-w@mail.gmail.com>
Subject: Re: [PATCH net v3] net: ntb_netdev: Fix statistics races
To: Koichiro Den <den@valinux.co.jp>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:16=E2=80=AFPM Koichiro Den <den@valinux.co.jp> wr=
ote:
>
> ntb_netdev updates shared net_device stats from per-QP RX and TX
> callbacks. Once multiple queues are enabled, concurrent updates can be
> lost.
>
> Use per-CPU tstats for packet and byte counters and DEV_STATS_INC() for
> less frequent drop and error counters. Callbacks can run synchronously
> in the xmit path or asynchronously from a tasklet or the memcpy kthread.
> Pin TX updates against migration in the kthread path. Use the IRQ-safe
> u64_stats helpers because netpoll can invoke the synchronous path with
> IRQs disabled.
>
> Let the core manage tstats while keeping transport teardown after
> unregister_netdev(), outside RTNL. RCU lets unregister wait for TX
> completions already updating stats, while later completions only consume
> the skb and skip accounting and queue wake.
>
> Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi=
-queue")
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v3:
>   - Use core-managed tstats and gate TX callback work under RCU (Jakub)
>   - Fix reverse xmas tree ordering overlooked in v2
>
> Changes in v2:
>   - Make packet and byte updates IRQ-safe in netpoll context (Simon, Sash=
iko)
>   - Use device-managed tstats and restore the original teardown order
>
> @Eric, thanks for reviewing v2. v3 moves tstats management back to the
> core and adds RCU protection following Jakub's suggestion, so I did not
> carry your R-b tag. Would appreciate another look when you have cycles.

SGTM, but at some point we probably want to make dev_isalive()
available instead of copy/pasting it.

Reviewed-by: Eric Dumazet <edumazet@google.com>
