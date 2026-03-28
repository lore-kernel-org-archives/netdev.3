Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C6CA45
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774687571; cv=pass; b=ueUNF7L75e/xoBkmoQ/bvYkqYSR4lXAWcxHlgQsggtbOgWlrdwjSNUWD62uszWKKzKLOjHCDyRPieaO22PpafPLl0xxpZM7+QghQkkXhkLxYRx4ZesIkR/pKeJng2HOlN2397GXJLEH9Q1sA40dPEj6xKvThT1ZqV+qfkQGvNmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774687571; c=relaxed/simple;
	bh=K/UbmGN/72AaYgX/CJ9wb6wBsiOtMsCmudW+wBwQhX8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vq0FhBkPAp0ndHnMD9MXSXAzBDNORep4jKvGXgUxY3gLKu7x6aG1+ZKskBmCzqTu9OOM9cdBG3upvjOo8JBf908fF0Aj4rgYTnRZe9Tphd76lqn4133IxgrE4Zbgwp2GYjWA93mRxKAPedXJnZGdH/OypSXsRLYC98QIM3QbyUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtJgGcCo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=arNFv+Qk; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtJgGcCo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="arNFv+Qk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774687569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7CxQJHl9Hw7qUi/PdVHY+CuQSX8WPUUYG2uUd7cIgjE=;
	b=ZtJgGcComwKsFgpxhza+wTUc5kSnSBaG+BfzRpNxIC2MtDJJijc00FoASg60j14wM/NblD
	XeP4eqsMFYAwJbNGp7u8uOZNLhPlEaIcdcl7Zz4vxABD6bdlq8KjAXnR1IGWTkVdDkTnao
	9CDgtL3+QqG8EzZUBJr77zjWIQPK4eo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-DoL9tvXsPtONuksknjkP5g-1; Sat, 28 Mar 2026 04:46:07 -0400
X-MC-Unique: DoL9tvXsPtONuksknjkP5g-1
X-Mimecast-MFC-AGG-ID: DoL9tvXsPtONuksknjkP5g_1774687566
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4670643ebf8so6720807b6e.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 01:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774687566; cv=none;
        d=google.com; s=arc-20240605;
        b=Utun4xVnPztN/4f1SIc5sy5PmrXVBfoKXUx2qq/toVLFMHBkoZhcxF1Z+UHtCukxYr
         OhMEC1GD0DOKZlCcrGAz9xKxE1itvvPQ66Suj/WwKq4h8XV5PA+mqFfgF94P2UeO0sQS
         3RLWdHYOHJPO6T/Mh5jdBuOVNX9R1kAXtvus+9vTIOyibsso1PRGVamcXFw3RLYN5Rv2
         u2Y2C2IBeOIFGZWjNwktdUWz5JR2TZx4Fl8y7Br6MrH+AV+UFNC//yv17pxNu9OKH9V1
         lVuVxX9yVOM20N9dzfCUNqD2QKInLEeXasrcCQJ494cs6RmBaG5TYzbzsd/hx9VmUfit
         92bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7CxQJHl9Hw7qUi/PdVHY+CuQSX8WPUUYG2uUd7cIgjE=;
        fh=Km4Z6wgQagtUnstWak6TGtG3VntaYmC4Du42dubtIdc=;
        b=kNLEDVqVSj0BhoRwdkzdnIrtUunEO3yFk5w5g4kNcMbUJh2qxNU8L4lz988lG/JsXs
         rLm5P+p1kpU7cW+G+JHiYgU5PhiHFYwZQfyMkdTwT09OIkjCFsgN86633RTmYh5X3L2p
         sZbDtJZSmWvlKFYl22iYOpX0ptfK+G2fCUljmLO4E5Salgw1DB5Ly5CCMes68P7RS8+M
         eV3aviv0C/Hm5DXsg6//zw2w4Lveuyu41f+UgOP2JmX+ChmJRqGZe2dkBZ0lgwnjq5Yt
         ro5VOWljQcPYmtVIbOluMAvod94zFBqTs2TJ3W9UbmXxiGCO0Ae/Jj1EN61k9kHFUNRn
         R3YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774687566; x=1775292366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7CxQJHl9Hw7qUi/PdVHY+CuQSX8WPUUYG2uUd7cIgjE=;
        b=arNFv+QkK8iZ7BXNUJjiTg+PALxL6GbPaFPjJqEz2xdLVkXQM61sYQZxFKJY375xrn
         Kf339s4+4KKz1TQGrS4ZmvyJmcNgGqYcRAcMW2XmvqxP7f7KmRG8Hj7B4QX5SNq0P+qP
         dV1uDZncACdsvWhb5CmOSg6S4cczB78zGucY1v9+X56yTiIJkBxYdcW4WWXKvlXb9pEg
         V8DmLat33LpGAfkmA3/smrnYQ326RHxXLf4OJZiT7xnJR6OgcVXp8AooWFsX9Oat3bf8
         Rs75cWHbvZ0cPAapOS3UVcYWSfumE75w1DJo7aeKl4NGg0YqmDrD6qGWLb1sWf6HTjl1
         cE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774687566; x=1775292366;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CxQJHl9Hw7qUi/PdVHY+CuQSX8WPUUYG2uUd7cIgjE=;
        b=BRRbKu2kEPppgB2QoQLAfeDxn6Lu9oPdrgQq6sQLXTobuG/D0VBHrN2+0UOK0LJTv7
         Snhjv4So4MjXI+QiWDB/rmOC6Q3BwEbJoi7g0n12F65HtxKTZFG/QsDaTyeSSJbaONxi
         Gu3+seIO0mfn1N0I81wQev0aINCe6bDABZ+F5bbT4H4WdDMSRzHV8lbujKZWClGD7D6s
         wjcicJmrPqDuM+gwgn2z5NW+pNS7bI2MqPsN5z/DZHZmXJIA/e36qa2hK8HpxLyKCwkI
         uufSVf8tA+Jv6OgA6YXFi6qOvBBaWRM1I5TTOAbCfiORF7qNS9IqXx6GtbYM/KyBZzdB
         kDyw==
X-Gm-Message-State: AOJu0Yyc8gzQSVRk1F9J3EpaBwOK5i9DqvUtrh7cBG9lr2kKOPS7qU7m
	VbRyA3hGJJDs9bjPd/4AuRe+ntmFw28P4FZC9nR2IxMGS4OCtEmz5CcUEo+cg3uAsF/zM4XoPdj
	++2E7Fzcrr1Xi2pgXGHVN1FFldSkz4EPCcLQWF2lHEENDxDu2uRiAtcWoqkyWZQWHpY74/yZyHO
	fu/D/1q+Weqdlzx+rrP49i+hNTGv5myob1JhOhMeesPes=
X-Gm-Gg: ATEYQzxw6cxOcl1yVqLeYMK1evs7ECgHYnKk+3EUcFwuYFXNTA1BAQNx4uBEaen9V6d
	0zibCn9mnYYAw/Hu72CYncGPxLnILmEKJrEzho2//BMsY1UV7ED75WEoYPDJrBcKdp9t7T9YvDg
	NNRzNF+7hE9/HkksAEx+eJsl/oUNj5QhylSs8O8+XYCPGJjRrb2q973uO+fVXjv5ET2Jz4Dfs2h
	ulP
X-Received: by 2002:a05:6808:1925:b0:466:f6ee:5bc6 with SMTP id 5614622812f47-46a8b0d4a7amr2541785b6e.27.1774687566375;
        Sat, 28 Mar 2026 01:46:06 -0700 (PDT)
X-Received: by 2002:a05:6808:1925:b0:466:f6ee:5bc6 with SMTP id
 5614622812f47-46a8b0d4a7amr2541776b6e.27.1774687565925; Sat, 28 Mar 2026
 01:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vitaly Grinberg <vgrinber@redhat.com>
Date: Sat, 28 Mar 2026 11:45:49 +0300
X-Gm-Features: AQROBzCJp8gydph4mrF26uXbxbWuEMvJOTAAPc-10topUVWRLBOTyfZgP0R0U88
Message-ID: <CACLnSDidL2kgT4z6bdHuhPZ+Y8Vb0dgj2tNNj9VDPJ31-gCsoQ@mail.gmail.com>
Subject: [PATCH iproute2-next] dpll: Send object per event in JSON monitor mode
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"

Previously, monitor mode wrapped all events in a single JSON array
inside a top-level object, which made piping the output to external
tools (such as `jq`) impossible.
Send a separate JSON object for each event in monitor mode,
making the output suitable for line-by-line consumers. Skip the
global JSON wrapper for monitor mode.

Signed-off-by: Vitaly Grinberg <vgrinber@redhat.com>
---
 dpll/dpll.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index 7b05bf86..6736c85e 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -571,8 +571,15 @@ int main(int argc, char **argv)
  argc -= optind;
  argv += optind;

- new_json_obj_plain(json);
- open_json_object(NULL);
+ /* Monitor emits one JSON object per event for streaming;
+ * other commands use a single JSON wrapper object.
+ */
+ bool is_monitor = argc > 0 && strcmp(argv[0], "monitor") == 0;
+
+ if (!is_monitor) {
+ new_json_obj_plain(json);
+ open_json_object(NULL);
+ }

  /* Skip netlink init for help commands */
  bool need_nl = true;
@@ -602,8 +609,10 @@ dpll_fini:
  if (need_nl)
  dpll_fini(dpll);
 json_cleanup:
- close_json_object();
- delete_json_obj_plain();
+ if (!is_monitor) {
+ close_json_object();
+ delete_json_obj_plain();
+ }
 dpll_free:
  dpll_free(dpll);
  return ret;
@@ -1840,6 +1849,7 @@ static int cmd_monitor_cb(const struct nlmsghdr
*nlh, void *data)

  mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);

+ new_json_obj_plain(json);
  open_json_object(NULL);
  print_string(PRINT_JSON, "name", NULL, json_name);
  open_json_object("msg");
@@ -1849,6 +1859,7 @@ static int cmd_monitor_cb(const struct nlmsghdr
*nlh, void *data)

  close_json_object();
  close_json_object();
+ delete_json_obj_plain();
  break;
  }
  case DPLL_CMD_PIN_CREATE_NTF:
@@ -1867,6 +1878,7 @@ static int cmd_monitor_cb(const struct nlmsghdr
*nlh, void *data)
  json_name = "pin-delete-ntf";
  }

+ new_json_obj_plain(json);
  open_json_object(NULL);
  print_string(PRINT_JSON, "name", NULL, json_name);
  open_json_object("msg");
@@ -1876,6 +1888,7 @@ static int cmd_monitor_cb(const struct nlmsghdr
*nlh, void *data)

  close_json_object();
  close_json_object();
+ delete_json_obj_plain();
  break;
  }
  default:
@@ -1941,8 +1954,6 @@ static int cmd_monitor(struct dpll *dpll)
  goto err_signalfd;
  }

- open_json_array(PRINT_JSON, "monitor");
-
  pfds[0].fd = signal_fd;
  pfds[0].events = POLLIN;
  pfds[1].fd = netlink_fd;
@@ -1975,8 +1986,6 @@ static int cmd_monitor(struct dpll *dpll)
  }
  }

- close_json_array(PRINT_JSON, NULL);
-
 err_signalfd:
  if (signal_fd >= 0)
  close(signal_fd);
-- 
2.52.0

