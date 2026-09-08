Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB4511184
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911124; cv=none; b=DxuvSYJ3nIXhZHuDMh0FWYb63jGhavBfulTHOws1dyY62df0xTVOrkoqvQ/AdOTADB33ZC6gGYwumce5V9SseMAtv76eMFuMGex8tG+dzY2zHTzn4d6C0LLD45xxrP6VjJPR6qy6z01QiwDbd6kOZppce46Gs2CP7NAlbDymDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911124; c=relaxed/simple;
	bh=Y/hoSKnUCJ+qLSjPn+IHO3Agb8RUz0LOCMZy00mpR/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQqv5I6XsjE0KvBjLElm3ac7NxDGEOSnDHll6UZkMbiO1M6I2zlQF+V2xB36+9aT+1aXElz6p2UooPirykDp0jdqFj3XkDXvSo+FVgKkSGeuI4hx540Z7vgkNhjcgJbw2Acp2TEm8x8XvCIXS52pUjj1HucsxLyD+BstA42QITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onyDnFDw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onyDnFDw"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-939b8a5584eso163572385a.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 16:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788911121; x=1789515921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCcjGI0c3b8hQ4t5uTNFVaCAwxBXVaF0bs8I4YGo9l4=;
        b=onyDnFDwkjgm0ptg5su7LlKMRiVjxvVNAexwfO7gTW6hIyurDnrArp4ijVsdWad+48
         vTP7qYRimsMe9BSgrHLurXjwFfpw6tyrkhPJiNrNWQuvHXu9EN8FK+3q44+yrdczvldk
         l9QYaH/uxIW1HaJf0WQoXPGGLQ0KC2Im1jzEciIXSl2YNEKuhQ4YQcobZaSKRMXTWphf
         KuZeNX9YdlEeaX91ou9MVTb5IMB6nLmAyGsi2zRa7Vtq0fU1Enmtz0av4N41nk5hsdgw
         UnOgwwt92wXY1GotmanRNfV+1nDLeqyrcC30TkLLJNxQszU2fmxGVi3UdoQT2QNPecp+
         qKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788911121; x=1789515921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCcjGI0c3b8hQ4t5uTNFVaCAwxBXVaF0bs8I4YGo9l4=;
        b=tI45JuLLRFMkauIqLOYKtGVLGVWMbR+1Ke+GWnc0EW6paVa7RgRbuZmiIHSy085D9n
         7vWyvYOLviVRMZmBe1ggfZaiK0QZ+RAKFpkARfij+cWYQCnhzWDnI+Nsc61p7vYv3ACN
         kIU+I5gPBvtAvYNqlC2Oyr9YNqhg9YYtFPaKe4ArAqo36GMf0N2fJNs2C3rijNknwreT
         FWvYUi9pPH++APn+xUtFjR/caOA5Gmbx2jd17LOAWTNVpx3quVZ9fU+fqkMPhHStmP4V
         3DWtER4dxTbw9d3CoN4kIpzX/NcSCJtakObbg88sRb6j0swGeapmDGUT26z02KELhpGZ
         mLfg==
X-Gm-Message-State: AFuF++ksAyRNwJvDzr0KXUwTFnm57fv32b0r3q3UKnIiypCmf3XibhbW
	JrLx/wlx8ZsQRZUi4y2h/JW8r3CK9TlYbax6blFxQSxaZka0eHaP0JLK
X-Gm-Gg: AYBFou1gU2SyKtj9eWduved89bESAJfSj9tPR5MfTQcDTHu7APXjaQJjNyiwXpJcd+u
	E2NVud+mt3EOvwIjFcnJmKkSdK+UYWWULqeUBAqRm2utimt6xg84VThqtbluQ/Mk2SX6UfgVA+t
	bcLdN4WDjwwgIZ0ZXAIiuGHKJwAKOaBsEOEfmEOdGfhjiUSZ7mS4hm+LlXGrwBTR1c+O/oFrL4y
	/2wxy/t90J5P/kDCII7owZKegTaqlLNvUny0fx3rOSPWkVV1pXgvPHkqMH7RZ0Moeks+XAX9Dnm
	y4BcnzTDQex7OmwQHgI2o8slsiV/6IsYDkug1PLhHUPwQNn9hnwBMip8D4cBbPId5ZhYaKKtOs0
	3SZE/ZAtP1VVvgEu8icbJ6Rzs1bNOCOXjDXbqOGa8oGAw18o6mFu1MoJEhpVFAP64FcZgPf9jqa
	QpWJVuhViDGicYIJeLOXnpjDWlrA12s4kNfZ7OThjScXmD5XkYl2dlq1a+xJLQUVvlIEMKAUT1/
	3hbOqjUvA==
X-Received: by 2002:a05:620a:a48e:b0:939:7144:485d with SMTP id af79cd13be357-9398048a654mr2455504885a.38.1788911121049;
        Tue, 08 Sep 2026 16:45:21 -0700 (PDT)
Received: from elster.cvl.swallow.glass ([2606:8e80:692f:3320:980c:c29f:b4b9:c06a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939aff54ae0sm551872585a.8.2026.09.08.16.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:45:20 -0700 (PDT)
From: Taylor Bates <tmbates12@gmail.com>
Date: Tue, 08 Sep 2026 19:45:10 -0400
Subject: [PATCH net-next 4/4] tools: ynl: fix uapi generation for anonymous
 enums with documented entries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ynl-robustness-v1-4-f255214c0f30@gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
In-Reply-To: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Taylor Bates <tmbates12@gmail.com>
X-Mailer: b4 0.15.2

In pyynl's current render_uapi() implementation there exists a check
that is intended to ensure that definitions of type "enum" or "flags"
have a doc entry before calling write_doc_line().

However, this check still passes for anonymous enums since
enum.has_doc() still evaluates as true, so they still take the kdoc
code path.

As a result, this path attempts to hang the entry docs off of
enum.enum_name (which is of type None), raising a TypeError.
Both the ovs_datapath.yaml and ovs_flow.yaml specs will fail to
generate uapi headers in today's tree:

  $ ynl_gen_c.py --spec Documentation/netlink/specs/ovs_datapath.yaml \
    --mode uapi --header

  Traceback (most recent call last):
    File "tools/net/ynl/pyynl/ynl_gen_c.py", line 3780, in <module>
      main()
      ~~~~^^
    File "tools/net/ynl/pyynl/ynl_gen_c.py", line 3511, in main
      render_uapi(parsed, cw)
      ~~~~~~~~~~~^^^^^^^^^^^^
    File "tools/net/ynl/pyynl/ynl_gen_c.py", line 3255, in render_uapi
      cw.write_doc_line(enum.enum_name + doc)
                        ~~~~~~~~~~~~~~~^~~~~
  TypeError: unsupported operand type(s) for +: 'NoneType' and 'str'

The fix implemented by this patch instead generates a plain comment
in this scenario as there is no kdoc identifier to hang the
documentation off of.

Fixes: 690e50dd69ee ("tools: ynl-gen: de-kdocify enums with no doc for entries")
Signed-off-by: Taylor Bates <tmbates12@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 1c422141d2d7..66a6dbe07125 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3247,15 +3247,17 @@ def render_uapi(family, cw):
                 continue
 
             if enum.has_doc():
-                if enum.has_entry_doc():
+                if enum.has_entry_doc() and enum.enum_name:
                     cw.p('/**')
                     doc = ''
                     if 'doc' in enum:
                         doc = ' - ' + enum['doc']
                     cw.write_doc_line(enum.enum_name + doc)
                 else:
+                    # Render a plain comment, no kdoc identifier available
                     cw.p('/*')
-                    cw.write_doc_line(enum['doc'], indent=False)
+                    if 'doc' in enum:
+                        cw.write_doc_line(enum['doc'], indent=False)
                 for entry in enum.entries.values():
                     if entry.has_doc():
                         doc = '@' + entry.c_name + ': ' + entry['doc']

-- 
2.55.0

