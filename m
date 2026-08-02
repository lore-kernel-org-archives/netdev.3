Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304963233E8
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696268; cv=none; b=B/tiQWTs316JkUAGQqtYyyIDEn3ck6MFghQ/xzWQhra9tYSNno54XFU9SJDyOV0RVuvT/ZsYQVh9ocp08QbPtafGrHjM85J3lAQMS3a1CmJCedL4QPSAHQNYUNd2krdbw3orp3/9pCclGGtcYvUVWDf7h2W+pwaEuyCK93oMjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696268; c=relaxed/simple;
	bh=6uv1MxF2ZcXw4xVnHAtTz30qh8/OZ9JkZPxN57R7WXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBMyvnDmD4MsRMTOWyF8C493N9LlQg2cT5/NlEhKABccov0uEh9nd+JmcXLPUjKjU7MstqTgw+9PZz7qVXtRcXdII746kGDRj5WOfGSP7FbVpfpMSx5iExsJJTUUHzyhl12XtHCe5B/wHHG4cz202CELQeES+HXTuHJDmVAhvzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=v/FxJTJN; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="v/FxJTJN"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80bb41f7f3cso25520837b3.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785696265; x=1786301065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iJiRgCmPIsgq0YciX2+BVE5Kt/fR2DQuvz6vwnUXWtU=;
        b=v/FxJTJN2am33OuhBQDF8fSByLqzmt7ydxL37I90W95BX7bbtcHBZz3xhrVNanCI+s
         KLlWts1M3mGL+KOF8TAMat3Z2DoK91IAFzLk+lLj6QrE7bIsaWJtUUfpDzHpAZOn3NSF
         Ulf7cAQcagsmBKFZ9it81KA+CIMb4Z78MSl8i4xq2fL+ZjSprXRBvx+gJZZGL5gPYOg2
         pCqc2bV7/L7efwphwOm4znGG//ZgQYay19iFx5liMVJruxFCHf+JuOYjnKUhU4N9H65W
         JjAbtuQuL+FcD/mk6ulCsZjncqcemhALBLXHNlSuV1c1BI0d5zSnHlBm07lEZkRBZVw0
         4vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785696265; x=1786301065;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iJiRgCmPIsgq0YciX2+BVE5Kt/fR2DQuvz6vwnUXWtU=;
        b=B12OaWDxD3NFY9XEsvRGkRneVm/Drz+cG0fURG5otWzKCtvDrH4mZ0asrAt9zwnFkh
         0Hoo00Gv+OgrfeAgge8EJ4cP+L6+ourGSsphItnKrITDby7Kd8aXKJvvGfuuvSmR/51t
         aRPXX091aiPC6PtinW9K7DVs2b/ZU3/S0tLC/X0UxwFSl1X9+urVBam2mI8DBrlBlKUv
         GnCIAMJQlgrLK6Mn35uZkF8JKg8sa93oCLXHkM9pdGJEQs1Zr06SUtxNHUvlVduEnZGF
         eqw5qNVvBSJuulAhvAOMi27z44h47BosPc0TL+wtNM0VfXPLb45ThItdnYXPE2RTz8N3
         u6ow==
X-Gm-Message-State: AOJu0YzHNLc8+X7NQEEgyZ/ZvoQNi5nw3IKLa3geffyS3H7cKZeB4RVk
	CfcCHFRYc/wYtdmNG0Zahr/fm8SBfJD85IDMOtMFHhuI23NzVUzmHHhjygA9IeYufNkElgAJgDe
	XovY3
X-Gm-Gg: AR+sD13U1SkS/5UGHWh0HXyeN3c0dmvWNETYoMTtfkXJplmWw1kJnDfayq3TpT/rPJl
	62LWaIVUEpQYZ8CoH22aP3W/1BCQrqxYxjRj3ApSIzmmfrPXosKyWFIZC9km5IdMbQxsdJAP1i8
	WxX671/5t04Bi+V5mdn9FKvfhDKmr5tnV/wssn9bmd/Bg+SqN0QFUODls6PuxXOZOUG/e0yen+o
	zGazwc0wh/KSXy8CudJ8F4Hn44ekmOIPrrhpCm5BF/dhgoM5TopDYdGdXOfBTfj2rm5DEuDfhsc
	srVxsa4+uXvFopopUm248LcLeTViAjRVtGfByvIIvBPFMtxxBDsH1b6/tjxGgIZCipqFRfjOk0p
	Ff6HTD3/1KucCn6Oe3pBu3hFaGL+MikBBsj0bVkcJdYcs53SP+V3GDnkVBZKi7eCNfNzVVR3TO/
	at3fFZg6/gR9lCo8mUNWgmdu6GvRyetrqPR2Yjml3ubb4RZISd494mH2WniLzLzsBwSNfS+xFuR
	mgnFtjyvsTG+qVqlKDqMszS55as67mtn9qwUcn8
X-Received: by 2002:a05:690c:6a85:b0:81e:6c2e:f114 with SMTP id 00721157ae682-81fd4b924abmr103566617b3.30.1785696264999;
        Sun, 02 Aug 2026 11:44:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf2cae7sm43500817b3.2.2026.08.02.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 11:44:24 -0700 (PDT)
Date: Sun, 2 Aug 2026 11:44:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Gonzalez <gonzalez.williamalexander1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] bridge: tighten VLAN parsing
Message-ID: <20260802114421.32eeed65@phoenix.local>
In-Reply-To: <20260801024051.10581-1-gonzalez.williamalexander1@gmail.com>
References: <20260801024051.10581-1-gonzalez.williamalexander1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 22:40:51 -0400
William Gonzalez <gonzalez.williamalexander1@gmail.com> wrote:

> ---

It is good to see more input validation but this patch fails the basic
requirements of iproute2 submissions.

1. No Signed-off-by
2. No commit message
3. No explanation

Longer AI generated review.

Subject: Re: [PATCH] bridge: tighten VLAN parsing

On Fri, 31 Jul 2026 22:40:51 -0400, William Gonzalez wrote:

This patch cannot be accepted in its current form due to missing required elements.

## BLOCKING ISSUES

### 1. Missing Commit Message (REQUIRED)

The patch has no commit description at all. This is unacceptable for iproute2.
Every patch MUST have:
- A clear subject line
- A description of what problem is being solved
- An explanation of the approach taken
- Examples of before/after behavior if applicable
- Signed-off-by line (DCO compliance)

### 2. Missing DCO Sign-off

The patch lacks a Signed-off-by line, which is mandatory for DCO (Developer
Certificate of Origin) compliance. All patches must include:

```
Signed-off-by: William Gonzalez <gonzalez.williamalexander1@gmail.com>
```

This certifies that you have the right to submit the patch under the GPL-2.0+
license and that you agree to the Developer Certificate of Origin.

## Technical Review

The technical changes (replacing atoi() with validated parsing) are good, but
there are issues that need addressing:

### VLAN 0 Handling Issue

The get_vlan() function rejects VLAN ID 0:

```c
if (*val < 1 || *val > 4094)
	return -1;
```

VLAN ID 0 is valid for 802.1Q priority-tagged frames. The patch needs to
either:
1. Document why VLAN 0 is rejected (if intentional)
2. Support VLAN 0 where appropriate
3. Have different validators for different contexts

### Memory Allocation

Using malloc() for parsing 4-digit numbers is unnecessary:

```c
start_arg = malloc(len + 1);
```

Better alternatives:
1. Use `strdupa()` to avoid malloc/free handling:
```c
char *start_arg = strdupa(arg);
start_arg[len] = '\0';
```

2. Or use a fixed stack buffer:
```c
char start_arg[8];  /* max "4094" plus null */
```

The `strdupa()` approach is cleaner as it avoids both malloc failure handling
and fixed buffer size checks.

### Range Validation Change

The patch changes behavior for ranges like "100-100" (single VLAN as range).
This needs to be documented or fixed.

## Required for Resubmission

1. **Add proper commit message** explaining:
   - What problem this solves
   - Why atoi() is inadequate
   - What the new validation provides
   - Any behavior changes

2. **Add Signed-off-by line** for DCO compliance

3. **Address VLAN 0 handling** - either support it or document why not

4. **Remove unnecessary malloc()** - use stack buffer

5. **Clarify range validation** changes

Example of acceptable commit message:

```
bridge: tighten VLAN parsing

The current VLAN ID parsing uses atoi() which silently accepts
invalid input like "123abc" and treats it as 123. This can cause
user confusion and unexpected behavior.

Replace atoi() with get_vlan() helper that:
- Validates the entire string is numeric
- Ensures VLAN ID is in valid range (1-4094)
- Provides clear error messages for invalid input

Note: VLAN 0 is not accepted as [explain rationale].

Before: bridge fdb add ... vlan 123x  (silently uses 123)
After:  bridge fdb add ... vlan 123x  (error: invalid vlan)

Signed-off-by: William Gonzalez <gonzalez.williamalexander1@gmail.com>
```

Please resubmit with these required elements. The core idea is good but the
patch needs proper documentation and a few technical adjustments.

NACK - missing commit message and DCO sign-off
