Received: from mail-ua2-f32.google.com (mail-ua2-f32.google.com [74.125.226.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B828212FAD
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790304506; cv=pass; b=BbKMnGjZVgKZIcfT9TM1Wb5s0cFdSBziy+scb2X3dMBOzAt8hlzS6GTmmDKd1JZwghdOIcg4Nh7AcXQDNM0X7ymPCSpb4y7bqIyU6lZVZtF6aHbvsDmf0tLI+07FuZ91DeQJgrM7baYKO/K1gVZQ8pByDUnr1NJUdB6u+HMBg6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790304506; c=relaxed/simple;
	bh=A8hFAHnxyUJuEG7oRFhxbJa0/9QTewsyA1sPcU4Y83w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Rre70LO8ail5GLrURvCzkEzN7enhIbDW7F5CvCYe8MVWIEGg9t+hcpida5uLQ2GonyiueMeEtcx3rNexjb87ps5Sfeaccv0kVceBrssv2ERNlIeoQ0u2Qsd6OgGMZwm7GbHME+KbG7yaExJMP9HhFN2NN+xcuWm3hFezQEOLhqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA4ErD6t; arc=pass smtp.client-ip=74.125.226.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA4ErD6t"
Received: by mail-ua2-f32.google.com with SMTP id a1e0cc1a2514c-97e97e2c7d4so290531241.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 19:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790304504; cv=none;
        d=google.com; s=arc-20260327;
        b=XbQdkO62ecGeSWcESabY9eSpyYNNoMopevx3COgUNpWJXiAONKlKI/CWZm0321lFO0
         BkdcdsKPGzSoC12rUeSL2ZNu5FhhTO6kzVkBjhe9aVuxJvu+w5/es3OoBs2Jyl2+0Mgf
         OGBVJPiTSoU76bx7qRRXs9a3OO/vIhfIi7EfqLefOAnNNLrNETk+jcu9F8z6kjG/j6G/
         v1GtXKTa2IkpMx1bDzykAYygBFPkfwi2cjnFD/GEKcb8ZpzrKk5R2mEaS5vKby3JVziV
         SDZqXVJ0eH00VLD1jk2+1w6xTnk8ICqJ/NsLEEfg3/A5aSGWUqrJ6SvEe4slVbQEgDod
         geMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=086KJYBOEvQVApNcJ886DWoFmFsCYQjg0ptZyXxnLaY=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=rHfJ6MgQ2fC7RKCbyrvpcbkijRSUHs/PebP+INt092iyvylDRfM+hzhGCTYDV4yyMC
         ruj778k5sztBqR4rDCzb09CJZvl/f/xy3PVwCWTs6qjfpNHaWYdfkvjo915Er2qVFxoz
         Y5nJHCXHOpD3VA6trw3O459yKPqhdoYjXcH26B2ZY1fhDKRVBxJKsJqhL1Wtc1OKLfb4
         fo4Vm5L5opFqzQ/WDtiK+zUif9ywPgX0KrS7kZNDBShslB365taMW7addm09WRtNfFVZ
         FUA6Ojcrd1ouWtQ6l0rP1snkwsTgrk5qJcGQ0UaB1pJFWpH15EkF2wFaoPccWd/AE8wb
         rlxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790304504; x=1790909304; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=086KJYBOEvQVApNcJ886DWoFmFsCYQjg0ptZyXxnLaY=;
        b=LA4ErD6tMFR5Za++SoUbroXYwJcD5l7D6zhMkO7aCy7SJ/9FrLEbBXB4ux2DXb40K6
         MYIb8/0nlf5vKFAko77MFm+XUo6BKM0L8LTzqcngqmEWvbzb8UXZo6gx/PkDASKQLUT9
         Wgy7OmzjYzygrMqeuO812alXLMu8xZ4U8HYlFrPqK49z78tlYKuVuSg+Nvn04NkQpSU4
         5KjtJtrtkUOChleInNGxDVgmdzRYhmtfEjae1IKslOjW2k1CwTQvt4KhRN9yCVc2ZzrH
         6z49fVWqxW3+3aApLd9eOMLKneFAyyMygJRMdXljaRvwNJ5ayEvqAARNzjLowRXH8Ez5
         T/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790304504; x=1790909304;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=086KJYBOEvQVApNcJ886DWoFmFsCYQjg0ptZyXxnLaY=;
        b=IMasIDAQDRusJA+qyQHNcDd2rnAZjv4WBpFyWD3sapz9h0EhhsHMgWMDMNbjtFA2gj
         zCcni6KbU1U55bvstWkCXdeme6aQ+6BBd6u3O4hEJBqP1U7CIY0lthhBd+88nVWjN/ga
         weizhfAfhq+5kiz4eZiUjRxITIPtwum0W1UL5bn/JXkmJN5DFN7IdVhC5wgSxaGMdENY
         v4ezSj/EKtqiJFuiy+uIQDI0cH3DuHKUF21yp+EP6s1+bGhOb9ZCuIrAr8IXZcnrUjH8
         R4KvC5c+Ah/EJEO4K2PR4mukj89kAa961D9fsbSb8qdxzKaM7y6zgpigO4pUQKTCoHdx
         TV7g==
X-Gm-Message-State: AFuF++ksL8SvCvatwuTfk76pD9ipuIRcLM1ra9Ek3WqQU6aSOMDFZS4w
	J0PBT9K8k5mkd6Zcahc8zmDq5lW2T9pC1otbRCfZ2DTC6FJ1gFTxT/vfMNMHH/sKGuVYj3J5smw
	abQyioXb7u/zppHY4mFYqeNWVUdQ76G5NyGbIuD7dcQ==
X-Gm-Gg: AYBFou0fbQGWsxe5L7ZlrBxV5Q11NT9eMIKJyOhzhNGaY/QVj8mKW793kr3zUrP8wnd
	oIlnr8ibqGe1q7iIIY9isMxd0R+YJ1og8tDZViMujChaCtotZEoV27epneeFCfIxn0Jd98izyEf
	5bInY4vA027J8pFA5UnU5h8FPSG64Si7OJP+BmLojDjrlM23opkStGOTLZgkZV1LE+/qlFyvgpl
	ESlts94m3wF/LCVycPlGrS4tporSC5rZhE0YUtEWt0gADJ0DstKkEHcq/i3fTk4tugKEyrko3BY
	16E+Q0qAkyRbsmC86mz98EYPIQnXl0xktJSxjPTFigXSb6udJqDP53IlTcyJAnuxr5n0Xjj7wlO
	P43yaN7GPdA==
X-Received: by 2002:a05:6102:5346:b0:79b:f57e:ea17 with SMTP id
 ada2fe7eead31-7af1c6921f0mr2362971137.3.1790304504335; Thu, 24 Sep 2026
 19:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lane <software.research.development@gmail.com>
Date: Thu, 24 Sep 2026 21:48:13 -0500
X-Gm-Features: AclHuK_LY3Y2WpMYypQixFlGx4xKWeM_UYSrEdOR7yeE7aV9z_5stRqbOVrbxEc
Message-ID: <CAGchGNseHg7k=Ubtmck=Tc0U3z=wJefEE5kKdH1wxOH5wXS4PA@mail.gmail.com>
Subject: [net] Search for net subsystem rust abstractions in-progress
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am following up on some advice given from the Rust forums where I am
trying to move some of my LKM's from C to Rust. These LKM's,basically
create new address family protocols using (for starters) structs and
functions like the following:

    struct net_proto_family;
    struct proto_ops;

    // Add a socket protocol handler
    err = sock_register(&proto_family);

These do not appear in the kernel crate. Per the
submitting-new-abstractions-and-modules section for contributions in
rust-for-linux, the second bullet point says to "check the mailing
list archive" because "part of the work may be already done or in the
process of being upstreamed", so I was hoping to see where things
stand and get advice.

I know the goals are not to duplicate or rewrite existing drivers, but
my modules have not been opened up yet and still going through heavy
development. I guess I am looking to know if there are proper API's or
abstractions for the net subsystem, otherwise, I may want to start
looking into contributing. It is also my understanding that we would
not want to be directly using any C bindings, rather, using a Rust
abstractions layer.

Thank you for any advice.
