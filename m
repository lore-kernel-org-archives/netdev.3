Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644C32A3E5;
	Tue,  2 Jun 2026 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424040; cv=none; b=PA9Z+O3oWg3HuD8fw+rIQ8vDELzWjQX0xirMH0l7ZChm1p8lzwvuBhWehcUHzdgzctvW5fFFPbGES35Ho1UwhtrX8I2YcUNzXnbXHO4voCI0U5DuzAQ8AgA2iM8QyA4e22mkt/eYvkgNREBQqRN2f+i0M8sLypQ1TdDtjkeUNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424040; c=relaxed/simple;
	bh=eesBN0BPOPihGRR1p8eDZIfoKe+EQ3AWPTFdOijTfi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO/tNoD4xTO7ULttfttWA1nMMb4AgB5a95EKXj15fXCmfqQKifRI6r5yt+hjk91oI6iseFg2+Y8J0kpg9ZsU+A8GoA2d3Hqf+D9FNh6dU3O+76z4gLvTB2QyUWn15VCZt5fD6BKaM1VMkNioN9cnblriyUY3O5sfzO/xZet3yTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb89jCjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb89jCjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF96D1F00893;
	Tue,  2 Jun 2026 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424039;
	bh=8rLawPCHAL6BBYPyo2KOh5us7pdengZX3vCbO6k6BDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hb89jCjQOBdr1CiDN0Xr/C+htvYq2scwrzLx9qaKrAk1TLQ2i0a1AeDSzJd8mzTZJ
	 v06HUjqOwtQCJFCKyTb5VMNZwwHJ49fi8HFLs9NmJ8JoxlYBJWqLKvHnNT0ivvW+7D
	 cOIL1PMnlt7VjfR4edVGZC9Ge6fBJF9zWCxcqb87gy9PwKWxdsEFCKMhxbO4vXWyXV
	 A5vk6vez3dqTM8P1jhN+kqzgCWT8erkSixh83+bv8KPfHC+xT8ujncl0aqiR1t4qWL
	 xex8OA43S9rTcrRIanUsBkY3UE4mVMDUmjyKHht++gIH98WFjlgJwZZeBOb4UvYIUd
	 rBQ2cfN9EDoRQ==
From: Simon Horman <horms@kernel.org>
To: zhaoyz24@mails.tsinghua.edu.cn
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn,
	fengxw06@126.com,
	qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn
Subject: Re: [PATCH net] net/802/mrp: fix vector attribute event count handling
Date: Tue,  2 Jun 2026 19:13:39 +0100
Message-ID: <20260602181338.3636444-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527084624.43057-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260527084624.43057-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net/802/mrp: fix vector attribute event count handling

This commit fixes an issue in the MRP vector attribute parser where valen
is not decremented after processing the third event in a byte, preventing
spurious events from being applied when valen is a multiple of three.

> diff --git a/net/802/mrp.c b/net/802/mrp.c
> index ff0e80574e6b7..40cb94182167a 100644
> --- a/net/802/mrp.c
> +++ b/net/802/mrp.c

[Severity: High]
This is a pre-existing issue, but does the parser unconditionally consume
the FirstValue even when valen is 0?

According to IEEE 802.1ak, a VectorAttribute that encodes only a
LeaveAllEvent has a NumberOfValues (valen) of 0, and the FirstValue and
Vector fields are absent.

Looking at the code just before the loop, it unconditionally copies attrlen
bytes into attrvalue and advances the offset:

mrp_pdu_parse_vecattr() {
    ...
    valen = be16_to_cpu(...);
    ...
    if (skb_copy_bits(skb, *offset, mrp_cb(skb)->attrvalue,
                      mrp_cb(skb)->mh->attrlen) < 0)
        return -1;
    *offset += mrp_cb(skb)->mh->attrlen;

    while (valen > 0) {
        ...
    }
}

If a valid valen == 0 packet is processed, won't this improperly consume
bytes belonging to the next PDU element and corrupt the packet offset?

> @@ -753,6 +753,7 @@ static int mrp_pdu_parse_vecattr(struct mrp_applicant *app,
>  		vaevents %= __MRP_VECATTR_EVENT_MAX;
>  		vaevent = vaevents;
>  		mrp_pdu_parse_vecattr_event(app, skb, vaevent);
> +		valen--;

[Severity: High]
This isn't a bug introduced by this patch, but does this loop miss an
attribute value increment when crossing byte boundaries?

When valen > 3, the loop wraps around to process the next byte of events.
However, we only call mrp_attrvalue_inc() before the second and third events
inside the loop.

For the first event of the next byte (the 4th event overall), it seems we
use the exact same attribute value as the 3rd event rather than incrementing
it:

mrp_pdu_parse_vecattr() {
    ...
    while (valen > 0) {
        // ... read vaevents ...
        
        // 1st event uses current attrvalue
        mrp_pdu_parse_vecattr_event(app, skb, vaevent);
        ...
        // 2nd event increments
        mrp_attrvalue_inc(...);
        ...
        // 3rd event increments
        mrp_attrvalue_inc(...);
        ...
    }
}

Should there be an mrp_attrvalue_inc() at the end of the loop before
processing the next byte, or at the start of the loop for subsequent
iterations?

>  	}
>  	return 0;
>  }
