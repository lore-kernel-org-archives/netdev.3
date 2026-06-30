Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355F43C05D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830981; cv=pass; b=YxzEeUzh0AmCVPFTI4Uc4xO6Vr5h6EH7yt6D/eDziaOKg2CvGy7CUFK+wIk58ombnDRRT8cU+YrvFVSKJSO0XYZKfyE4FYRb6Cy+5cJ1yKBcfoPjMvJYIU5I78uaHqbD7VFyHQ4fcoIaeg5GC2S5DOuygFqN25+26HRXtbdWoQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830981; c=relaxed/simple;
	bh=R2RLlWKV31uw1vmm0eE8g4HAQBST/y2tQNtzmoB595w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDIxP2O9WTSuKRC6lvhBA6HBUUUPTNwFjDo6S5y5sBknZtPFy4c2GIHdKWpS5pW3Gf655Tr80BjUZW9wZs6U9ZuAk1UTHBdXF54EprFGMtCExdfHl+UGVEBbRU6Y6wH/h3qd4JI5ahQBVOrS9HX8BfqiT+31aP3r05h/KVLXhK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eguBgHH2; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eguBgHH2"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb89359a3so2132342e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782830978; cv=none;
        d=google.com; s=arc-20260327;
        b=F7lU5OSC/z+9yKEjGU+arrB0vcHjvEwIYFLOhc8SDYFQoeJ0r19M4qWKycQHdJ6JP9
         GhCAYG6T1GATtYKibKJT4qpAD18U+U4h+qU485FC/T6bfWLUcr0ycPNORKezKtp1hg+r
         fN6U9op9KHGRsUlVu97nHcjPWevn+q9XWHz9rZsHrZN5CBOk9UemXjq0IFTfyYslPH5o
         AbqCpQFKY8F5DVeA0gEGgp0xv6ZBpUou2GFg1my+vc2jAMKDqm9vo3/z/Zz3FhLdG1nC
         jE+yMb7UwzlscwoNpJm5gfKnNhGwD9p9vULY1kQWlUNLwE3TsFrZ8D/ORwxQ86ZsvTWN
         JR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        fh=b9o9xs7mxZEzFiU9iX/E9tVoZ56wmfpCcNe9kIcRFNY=;
        b=UwwKSlS7uUEmNo2xqOiJop13EORl1jTR9x4sUQvKzFbTu5S4qgV1RriKey96jQQ2L+
         EgMaMMI9y8yd0UZ7rUyvvb61WJZjLq6trRaNtFq9bSVW7D64cNWINVNrMaWExO0UXngy
         v0XE+OprkDsfGA0tjfZIYtJHG7q/1wz7etOhGR2k3B8RJu2ZqrYfUMyqBAlkf3Cpzs/d
         idsWwQcqbPwdINmyvlrqTv753YvKL9nEaGrLlT0iJg7GKo9Naj+sTkWVPr0A/9KHMFCi
         oyINa2Mitun8vfVpSt6HocrgTrM9D4QAg1f0YvjkyrPvW0f4rUZPuju6S7JYwAb2Y7AQ
         pe0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782830978; x=1783435778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        b=eguBgHH2CoPRAyRaOi3uiaGSli4ODNgt+uvPY+h/SIbi3UUzw5fgIYyM6JQzztjeNV
         3JlZ/ToxMazHgtcSpYy6Wanx8ZqhDUqqumustyQxJN+22k7vxLd4LMYm7+P0yLfn8pQ9
         JmK4CXxkJxFZX5JST3Z2ucXmDLXruN8OwppFZNOl6Ue/Rze31PgrmjMVcdVChqaVzkn3
         9z6twiYp4Zo1H82GIHWlqKbcTI38vd2yEWEiZYcXIzue3/HMx3mwR50ZIJUVf2D/Y4gU
         v2SGLfGE48Xhlw6IlpE/3my5ZFDfLd1udwdgHT/iCfuo1uBXsQroYQOJpyClQUxBsTNu
         CwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830978; x=1783435778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        b=DjYIVlWHJDQ/XExBtVnDW1Su7QMbbInluwIXll7ATM4GWtsNfBHIrUEfnzjGapxx+A
         sno9ICC7+IxZNFgLkatllSoHzFwMcPTcrsw4MEgljPcpLrWAx7bwa+ectBE6L+pkmzr+
         stuH5F5kRy5sacpJkCx8yitL44YMuZu+xwdy0QTHx7KN/gTXjJk4ohJY8awyk6wf0Jq4
         tFalXbkXP7VAsS7ASG3niQxep5q8WEUUr1zBjr8ngnKfM4oJA7da2MyEF979v5N1g/Nk
         uqFFe/arHnsS1EeYf8MWL+riJbw1tKCf3B4L2NL1QwBgaKBEHw5N8H6RUHwP7rfayBBO
         8BCQ==
X-Forwarded-Encrypted: i=1; AHgh+RolP/qHkUzZuCMrebLT2R/0eig3mtMY5sQD9AloxlWFIXDvzS85RDzMljzbSdD6OJpG9xi6G4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVFnwNJpZp2ncsa9Su2hDqyA4j/4CvOzOIvLZKPzsnLymhci+
	sPrAjMcQiTTEdlZmAR2txaX0s/LvHQLKYWAq8nW4HVSO6Yt4eltBLkkDCusjxjRDdal+A0QYIZ5
	yuUfIrZtHzl+y5SBmTr2hp3nq28uRxZA=
X-Gm-Gg: AfdE7cnf/KyKXOZ2QoW+evROif8/mhQ85NDACoGRALUpsKy8wYX3jI+8mGZPgVetK3e
	CcWUV8zdy+uWqlt+HuL3p4e2nysU3JgQtol9VnlT4t8e2/2mi3tPYPNfNaWwR+/sCis0lDeBdaQ
	14DUBuw5cxVryPGaCdQdNPIQKsfXsn7haoFvIAJlkIk+gKjyRYWHNW8CK2WBdvqM9pSfuIyg8zL
	/HJof/IcnwU0sxZPQPe1bN6EQek9IntxmHP6DPt4UU/rJ2oUCSyl3VpnmOxJxl9jN+Yk8s0yLRZ
	hq0N/Yhb0Dds1sCwb2TJI+oEAGzNLSdy4737/Ib0AcgB8caKmVYP8IMNtxJyr90Gen5zC0/cq8z
	3rvVeYta+6B2mJpOBJguW
X-Received: by 2002:a05:6512:640e:b0:5ae:b6cf:2869 with SMTP id
 2adb3069b0e04-5aebdb9485emr981524e87.23.1782830977995; Tue, 30 Jun 2026
 07:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aj5KJEIsTl6IK0nX@gmail.com>
In-Reply-To: <aj5KJEIsTl6IK0nX@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 30 Jun 2026 22:49:00 +0800
X-Gm-Features: AVVi8CeNolHc0bWFWi94se6V_El3cArCALeJfgf0e7sVp8JXgJSa3XDzBUrtcNM
Message-ID: <CAL+tcoA6=_paEdqWaY7-VHdBeAxEFeMCfTECAEGv3C6ZqFUNSw@mail.gmail.com>
Subject: Re: [ANNOUNCEMENT] LPC 2026: System Monitoring and Observability Microconference
To: Breno Leitao <leitao@debian.org>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com, 
	linux-mm@kvack.org, iipeace5@gmail.com, gavinguo@igalia.com, 
	linux@jordanrome.com, amscanne@meta.com, sj@kernel.org, gpiccoli@igalia.com, 
	Daniel Gomez <da.gomez@kernel.org>, mfo@igalia.com, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 5:56=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> We are pleased to announce the Call for Proposals (CFP) for another
> edition of  System Monitoring and Observability Microconference, this
> time at the 2026 Linux Plumbers Conference (LPC), taking place in
> Prague, Czechia, from Oct 5-7, 2026.
>
>   https://lpc.events/event/20/sessions/262/
>
> This microconference provides a valuable forum for key engineering areas
> such as:
>
>    - Kernel Health and Runtime Monitoring
>    - Hardware Integration and Error Detection
>    - Correlation of Issues (crashes, stalls, bugs)
>    - Virtualization Stack Monitoring
>    - Memory Management Monitoring and Observability
>    - Anomaly Detection Algorithms for System Behavior
>    - Automated Analysis, Remediation and post mortem analyzes
>
> The purpose of each talk is to share challenges and discuss potential
> improvements. Sessions will last 20 to 30 minutes and aim to encourage
> brainstorming and open dialogue about ongoing issues rather than
> delivering immediate solutions.
>
> The conference acts as both a knowledge-sharing platform and a strategic
> venue for guiding the future of kernel technologies to better meet the
> demands of large-scale infrastructure.
>
> We invite you to submit your proposals here:
>         https://lpc.events/event/20/abstracts/
>
> Please select track "Linux System Monitoring and Observability MC"

A kind reminder: at the bottom of the page [1], please click the
'Submit new abstract' button so that you will be able to quickly
submit a new proposal. (Admittedly, it's a bit easy to miss the entry
especially for the newcomers)

If you have any questions/suggestions/problems, please do not hesitate
to contact Breno or me.

Again, proposals are greatly appreciated :)

[1]: https://lpc.events/event/20/abstracts/

Thanks,
Jason
