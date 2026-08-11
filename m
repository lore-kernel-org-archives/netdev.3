Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1AF2737F8
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444191; cv=pass; b=H9qbkYei7VqlzoG5HADn42gD3AcrslfkU7z0k9s1QnjCcAxL004Frgvx70PEXTUwHzKNvj20E1++jxS/ZWQjlVUp0u3KdRT5XXQFZ2Qg1pxaz8CqThmNQhFeX7XDbmNZb/wN+PxqFpdCTFPfikuxuTKIBXpw+/iELjWK7cDEDbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444191; c=relaxed/simple;
	bh=vV6j1s1jfNbobXfHZOJ7gVCuxdmXS7u6pIWYzTwe5+k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=loxLduL5CvNM8iQPOAmAgcYKeZf5+enChu+Zhb0zQe/4aNTn9FgB5y9Y6M24Pdwc4a1OGu672jTCi85g/Hiak2iYzg3X5bX0lJ1Q63QDii7zJVDdK1uJBKEAqIFids0y+OrQBsh5jcHPueg+Ckab/sXI5zGBbYq+qaN2irzpA1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ8JNkY2; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ8JNkY2"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81eaf3709b4so37914687b3.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786444189; cv=none;
        d=google.com; s=arc-20260327;
        b=fp38LyDmk+G5ni/N6ivCRxnEP+QOZGigzPbdYbSE4SP4BzGz9/4IOnWZp612DfpMps
         jIJ/ibRPR24L0L/t50j2Crz8KvVJv6whTMaCpPDsON62+xyzHWsk8x5yVsdwLmMA+ze8
         yEFjaXSvbLG3D9xdad/0I++OXK2qhI6UbXGunw1MhPrWS97ppsFcy9iU+s1IQYXMBngr
         95ODQDzysibC17P09W+ulc9bArQ5rd5o9iDJy7dcJbKmI5Cu1uW+7NxkB01NrbibbKuo
         88tm3JV3qRLsdrolqWoczTI+8JB9DPC5T16HXy5yAnuozsYvX9/mPlUDuZr3ycN+GVf5
         dJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QAQsgQaaOtoDJkJmVBbHGkYWScTrg8DVQ7TUNA7V/qw=;
        fh=bm+FEDF1E/R3fUoDa0cj9VxVB8dXLwVgfreVwTZFo/o=;
        b=eVyGx54rjFrQCLh+lzae8sKiLT7YhoShUaB04MvSSj8oDIW32n7gbgBjV9y3HBntj8
         +qTOlQpCgpftK/zXOjdt7Fjq6RSzFfHpPed12lTi8/c7TkLutR8KYwSG87UFuIUxE6Od
         T9xA1vHV0HaEwgxyo0w62HunSqBty4O2mgXmzXYN0cjrdfx7PGdtpujVOdDoH43RfK+0
         JaTxMIMMJGa7dYxn8Dip1EcUshqDq6yidYArEy71AFM35tJ9L4R24y0ZubGjLmkvFHu/
         ZmwfkErOvh9e20ayfzV5hIk/L+Kp/jro6VzZ/fHCjW+m7SE1v57kJPFdY9jxUFU2zBHI
         n9zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786444189; x=1787048989; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QAQsgQaaOtoDJkJmVBbHGkYWScTrg8DVQ7TUNA7V/qw=;
        b=mJ8JNkY2oueDl1hDjZqpA3DonkraNi/F7/JP6vPESJfJsGXPkko7SNXxrZ6652bLdZ
         KYywDTpHmQLZh+untcnzUJ1mUgyqwDG384fyj/srz007n21uYDSBSldN3yD8qPyblLHA
         P8pJRZuFsfKLl9B/yWcDMOqk+h9RFbCyX5rJIE0o30bwEyRoE3kkpHpbf03FL35f1E9Y
         SlEZPlIRUIlxgO5RU7o3WzK2/7+Wyo1ZX3zvGU7aP/xrDKiJxcNuVvGC0S/wgEVDbB6n
         WW5y2dCIwPBs2OH1zsWzF3pRCLBS8p3GoCup/eogebcRXUY8fN/nAw7Qj/DpnvKAzVnn
         X3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444189; x=1787048989;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QAQsgQaaOtoDJkJmVBbHGkYWScTrg8DVQ7TUNA7V/qw=;
        b=CvOMElwIA9OEXKOLrtaAVuG8nvb+EH7BiXCDuC72z107551xO+Wb+m2WxLDD4WN6DJ
         GGb3Z1w9HAKDpWncFD2eEXL7/eQb8T80IuPco9xv7MwJ46+0UplintIvQnafUoofoI5p
         tBMGbor901cE5l85+k2KhvIBN22bbDyH5Q5Qb8+epXrFu+0YfkqCrYMEQMYCDUjUuSCD
         y4heRln4thJzRW3GIF7DzXjaoANF5WtWpSMh2Ntv2onunaQixAzUo4zEAO3uV7JL5HAW
         WArAgutb4WXN8wwsyf6TPgPjoNbxEhMGGd7NwdnCb0j+NIQ2r/FqmjXR5AWZBq6+Hkuv
         rbdA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3ES0FvnLcaKmTE+kVlHimczd9RznlOJod0R6fLHTn7IVwmF0KgSF4a+j4b/ApLmHx3BHaRr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xG6nJa4m7HBqBh1QVjYAEi7kTo4+O8f7ahR2VtZrs8RVKPbQ
	xCMGRd/f8gNnX8BMEuVdR+jW6rRNb8CtyxCHR1APps/NuHiso8IChtn/SnJxUPWyy2lUpT+c4Qm
	GGuaev6nt648Mf22thUzorfq+QKxF444U+OXyYjA=
X-Gm-Gg: AR+sD12R/ZlkfuXbDYO8kYG88yTQtFaXim/f9H3xAjZV8bEE8azAHyJv1d9cbelLHeW
	ZYMi9Hy1J21llJF1g51U6aYIcIjTqfsqhJ5EqNnracvlgIuMYm3DPSz5BVpLVRkGWyYjvTsMTHq
	TQlt7KoJN4ejHqFNvD7edSW34JT2rvcFPl0H7Dh1DASVvOMYALp7b+bNyOoPLIUWPGUeWjfFBH9
	KymUUguVy6jFN2m2gqXHo7YlSf9Km2XxcFr6Xehxi5YyiVpiLBohIj+QQZzRSl9f2yqIiWLQ0Qa
	/Ckwt17DBifgksGcKnHj577g7lqmS6MAMZr7T+jAISLJ
X-Received: by 2002:a05:690c:e3c8:b0:820:a55:3ca3 with SMTP id
 00721157ae682-82f2f1081f4mr13881517b3.33.1786444188345; Tue, 11 Aug 2026
 03:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wei Fang <void0red@gmail.com>
Date: Tue, 11 Aug 2026 18:29:34 +0800
X-Gm-Features: AUfX_mw3iYEfuoAC-d2zTxtii2YWdunbB05KKL0plR8gb7NI95vG49qfbpOJELA
Message-ID: <CANE+tVrDeNCHQVmsqkV2ozeBqyE3GtRDMhZgsg1bhw10yGNTRQ@mail.gmail.com>
Subject: [nf_tables] netdev chain: DELCHAIN with an exact device name matches
 a prefix hook and deletes the chain
To: pablo@netfilter.org
Cc: fw@strlen.de, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	k.chen@smail.nju.edu.cn
Content-Type: text/plain; charset="UTF-8"

Hi netfilter-devel,

The following nf_tables issue was found by metamorphic testing on
linux-next 7.2.0-rc6-next-20260803 (x86_64) and reproduced on four
independent VMs.  The reproducer is a single self-contained C program
that uses only the raw netlink API (no nft CLI involved).

This report is about netdev-chain device matching: a chain hooked
via the device prefix "vbug" can be deleted by a DELCHAIN request
that names the exact device "vbug0", even though that device is not
a member of the prefix hook.

Problem
-------
A chain hooked via the device prefix vbug (covering vbug0 and
vbug1) can be deleted by specifying the exact name vbug0 in the
DELCHAIN request - a device that is not a member of the prefix hook.
Deleting by a non-member name must fail with -ENOENT; instead it
succeeds and the whole chain is removed.

Steps to reproduce
------------------
netdev table, chain dev (filter, ingress) hooked with prefix vbug
(veths vbug0/vbug1 exist):

1. control: DELCHAIN with HOOK_DEVS {DEV_NAME "zzz"} (no match
   either way) -> -ENOENT;
2. variant: DELCHAIN with HOOK_DEVS {DEV_NAME "vbug0"} (an exact
   name under the prefix).

Both requests are symmetric: neither zzz nor vbug0 is a member of
the prefix hook's device set.

Expected vs. actual
-------------------
expected: both -ENOENT
actual:   control -ENOENT; variant 0 - chain fully removed

Root cause
----------
net/netfilter/nf_tables_api.c, nft_delchain_hook(): the device in
the delete request is matched against the registered hooks with
nft_hook_list_find(), which uses a prefix comparison (strncmp over
min(ifnamelen)).  The exact name "vbug0" (ifnamelen 6) compares
equal to the registered prefix "vbug" (ifnamelen 4) up to 4 chars,
so it is treated as a member and the hook is scheduled for removal.

Reproducer
--------------

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/netfilter/nf_tables.h>
#include <linux/netfilter/nfnetlink.h>
#include <linux/netlink.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <time.h>
#include <unistd.h>

/* NFT_MSG_* enum comes directly from <linux/netfilter/nf_tables.h>
 * (NEWTABLE=0, GETTABLE=1, DELTABLE=2, NEWCHAIN=3, ..., NEWRULE=6) -
 * do not #define the same names, it would break the header enum. */
#define NFT_MSG_TYPE(s, m) (((s) << 8) | (m))

#ifndef NFTA_DEV_NAME
/* Host headers lack the nft_dev_attributes enum; in the VM linux-next
 * uapi NFTA_DEV_NAME=1, NFTA_DEV_PREFIX=2 (verified by the Python
 * version). Defined only when the header lacks them. */
#define NFTA_DEV_NAME 1
#endif
#ifndef NFTA_DEV_PREFIX
#define NFTA_DEV_PREFIX 2
#endif

/* ---------------- Encoding helpers (wire matches the Python
reference) ---------------- */

static void put_u16(char **p, uint16_t v) { memcpy(*p, &v, 2); *p += 2; }
static void put_u32(char **p, uint32_t v) { memcpy(*p, &v, 4); *p += 4; }

/* attr: little-endian len/type header + payload, 4-byte aligned at
the end (len excludes padding) */
static void put_attr(char **p, uint16_t type, const void *data, uint16_t len)
{
    put_u16(p, 4 + len);
    put_u16(p, type);
    if (len)
        memcpy(*p, data, len);
    *p += len;
    while ((uintptr_t)*p % 4) {
        **p = 0;
        (*p)++;
    }
}

static void put_attr_be32(char **p, uint16_t type, uint32_t v)
{
    uint32_t be = htonl(v);
    put_attr(p, type, &be, 4);
}

static void put_attr_str(char **p, uint16_t type, const char *s)
{
    put_attr(p, type, s, strlen(s) + 1);
}

static void put_nfgenmsg(char **p, uint8_t family, uint16_t res_id)
{
    char *q = *p;
    q[0] = family;
    q[1] = 0;
    uint16_t be = htons(res_id);
    memcpy(q + 2, &be, 2);
    *p += 4;
}

/* nlmsghdr + nfgenmsg + attrs; returns total length (header included) */
static int build_msg(char *buf, uint16_t type, uint16_t flags, uint32_t seq,
                     uint8_t family, uint16_t res_id, char *attrs, int alen)
{
    char *p = buf;
    put_u32(&p, 0);
    put_u16(&p, type);
    put_u16(&p, flags);
    put_u32(&p, seq);
    put_u32(&p, 0);
    put_nfgenmsg(&p, family, res_id);
    memcpy(p, attrs, alen);
    p += alen;
    int total = (int)(p - buf);
    memcpy(buf, &total, 4);
    return total;
}

/* BEGIN/END: nlmsghdr(type=0x10/0x11) + nfgenmsg(res=htons(10)) */
static int build_batch_frame(char *buf, uint16_t type, uint16_t flags,
                             uint32_t seq)
{
    return build_msg(buf, type, flags, seq, 0, NFNL_SUBSYS_NFTABLES, NULL, 0);
}

/* ---------------- netlink session (same as b16.c) ---------------- */

static int nl_fd = -1;

static void nl_open(void)
{
    nl_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER);
    if (nl_fd < 0) { perror("socket"); exit(1); }
    struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
    if (bind(nl_fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
        perror("bind"); exit(1);
    }
    int fl = fcntl(nl_fd, F_GETFL, 0);
    fcntl(nl_fd, F_SETFL, fl | O_NONBLOCK);
}

/* receive acks (NLMSG_ERROR), collect seq->errno; wait at most wait_ms */
static int collect_acks(uint32_t *wanted, int nwanted, int *errs,
                        int wait_ms)
{
    int got = 0;
    struct timeval tv = { .tv_sec = wait_ms / 1000,
                          .tv_usec = (wait_ms % 1000) * 1000 };
    setsockopt(nl_fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
    int deadline = (int)time(NULL) + wait_ms / 1000 + 1;
    while (got < nwanted && time(NULL) < deadline) {
        char buf[65536];
        int n = recv(nl_fd, buf, sizeof(buf), 0);
        if (n < 0) {
            if (errno == EAGAIN || errno == EWOULDBLOCK) continue;
            break;
        }
        for (int off = 0; off + 16 <= n;) {
            struct nlmsghdr *h = (struct nlmsghdr *)(buf + off);
            int len = h->nlmsg_len;
            if (len < 16 || off + len > n) break;
            if (h->nlmsg_type == NLMSG_ERROR && len >= 20) {
                struct nlmsgerr *e = (struct nlmsgerr *)(h + 1);
                for (int i = 0; i < nwanted; i++) {
                    if (wanted[i] == h->nlmsg_seq && errs[i] == 0x7fffffff) {
                        errs[i] = e->error;
                        got++;
                        break;
                    }
                }
            }
            off += NLMSG_ALIGN(len);
        }
    }
    return got;
}

static int E(int v) { return v == 0x7fffffff ? -1 : v; }

/* send batch (BEGIN + n bodies + END), collect body acks into errs[] */
static void send_and_collect(char msgs[][512], int *lens, uint32_t *seqs,
                             int n, uint32_t begin_seq, uint32_t end_seq,
                             int *errs, int wait_ms)
{
    char blob[4096], *p = blob;
    int b = build_batch_frame(p, NFNL_MSG_BATCH_BEGIN, NLM_F_REQUEST,
                              begin_seq);
    p += b;
    for (int i = 0; i < n; i++) { memcpy(p, msgs[i], lens[i]); p += lens[i]; }
    int e = build_batch_frame(p, NFNL_MSG_BATCH_END, NLM_F_REQUEST, end_seq);
    p += e;
    send(nl_fd, blob, (int)(p - blob), 0);
    for (int i = 0; i < n; i++) errs[i] = 0x7fffffff;
    collect_acks(seqs, n, errs, wait_ms);
}

/* DELTABLE (inside a batch); deleting a nonexistent table -ENOENT is
harmless; used to clean leftovers */
static void del_table(uint8_t family, const char *tbl)
{
    char blob[1024], *p = blob;
    int b = build_batch_frame(p, NFNL_MSG_BATCH_BEGIN, NLM_F_REQUEST, 900);
    p += b;
    char attrs[64], *q = attrs;
    put_attr_str(&q, NFTA_TABLE_NAME, tbl);
    int len = build_msg(p, NFT_MSG_TYPE(NFNL_SUBSYS_NFTABLES, NFT_MSG_DELTABLE),
                        NLM_F_REQUEST | NLM_F_ACK, 901, family, 0, attrs,
                        (int)(q - attrs));
    p += len;
    int e = build_batch_frame(p, NFNL_MSG_BATCH_END, NLM_F_REQUEST, 902);
    p += e;
    send(nl_fd, blob, (int)(p - blob), 0);
    uint32_t w = 901;
    int er = 0x7fffffff;
    collect_acks(&w, 1, &er, 500);
}

/* ---------------- scenario construction ---------------- */

/* best-effort shell command; ignore the result (same pattern as b25.c/n18.c) */
static void syscmd(const char *cmd)
{
    int rc = system(cmd);
    (void)rc;
}

/* prefix hook needs real devices (same as Python setup()/teardown()) */
static void setup_veth(void)
{
    syscmd("ip link del vbug0 2>/dev/null");
    syscmd("ip link add vbug0 type veth peer name vbug1");
    syscmd("ip link set vbug0 up");
    syscmd("ip link set vbug1 up");
}

static void teardown_veth(void)
{
    syscmd("ip link del vbug0 2>/dev/null");
}

/* NEWTABLE: NAME(1) (netdev family) */
static void mk_table(char *buf, int *len, uint32_t seq)
{
    char attrs[64], *p = attrs;
    put_attr_str(&p, NFTA_TABLE_NAME, "t");
    *len = build_msg(buf, NFT_MSG_TYPE(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWTABLE),
                     NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE, seq, 5, 0,
                     attrs, (int)(p - attrs));
}

/* NEWCHAIN: TABLE(1) NAME(3)="dev" TYPE(7)="filter" POLICY(5)=1
 * HOOK(4){ HOOKNUM(1)=0 (netdev ingress) PRIORITY(2)=0
 *         DEVS(4){ PREFIX(2)="vbug" } } (prefix hook, no wildcard) */
static void mk_chain_new(char *buf, int *len, uint32_t seq)
{
    char attrs[256], *p = attrs;
    put_attr_str(&p, NFTA_CHAIN_TABLE, "t");
    put_attr_str(&p, NFTA_CHAIN_NAME, "dev");
    put_attr_str(&p, NFTA_CHAIN_TYPE, "filter");
    put_attr_be32(&p, NFTA_CHAIN_POLICY, 1);
    {
        char hook[64], *h = hook;
        put_attr_be32(&h, NFTA_HOOK_HOOKNUM, 0);
        put_attr_be32(&h, NFTA_HOOK_PRIORITY, 0);
        {
            char devs[32], *d = devs;
            put_attr_str(&d, NFTA_DEV_PREFIX, "vbug");
            put_attr(&h, NFTA_HOOK_DEVS, devs, (int)(d - devs));
        }
        put_attr(&p, NFTA_CHAIN_HOOK, hook, (int)(h - hook));
    }
    *len = build_msg(buf, NFT_MSG_TYPE(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWCHAIN),
                     NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE, seq, 5, 0,
                     attrs, (int)(p - attrs));
}

/* DELCHAIN: TABLE(1) NAME(3)="dev" HOOK(4){ DEV(3)=exact device name } */
static void mk_chain_del(char *buf, int *len, uint32_t seq, const char *dev)
{
    char attrs[256], *p = attrs;
    put_attr_str(&p, NFTA_CHAIN_TABLE, "t");
    put_attr_str(&p, NFTA_CHAIN_NAME, "dev");
    {
        char hook[64], *h = hook;
        put_attr_str(&h, NFTA_HOOK_DEV, dev);
        put_attr(&p, NFTA_CHAIN_HOOK, hook, (int)(h - hook));
    }
    *len = build_msg(buf, NFT_MSG_TYPE(NFNL_SUBSYS_NFTABLES, NFT_MSG_DELCHAIN),
                     NLM_F_REQUEST | NLM_F_ACK, seq, 5, 0, attrs,
                     (int)(p - attrs));
}

/* ---------------- main ---------------- */

int main(void)
{
    char msgs[3][512];
    int lens[3];
    uint32_t seqs[3];
    int errs[3];

    nl_open();
    setup_veth();
    del_table(5, "t");              /* clean leftovers from the last run */

    /* control batch: del "zzz-notmatching" -> chain delete must be -ENOENT */
    seqs[0] = 11; seqs[1] = 12; seqs[2] = 13;
    mk_table(msgs[0], &lens[0], seqs[0]);
    mk_chain_new(msgs[1], &lens[1], seqs[1]);
    mk_chain_del(msgs[2], &lens[2], seqs[2], "zzz-notmatching");
    send_and_collect(msgs, lens, seqs, 3, 10, 14, errs, 1500);
    int ctrl_del = E(errs[2]);
    printf("control (del zzz) ack errno: [%d, %d, %d] (chain delete
should be -ENOENT)\n",
           E(errs[0]), E(errs[1]), ctrl_del);
    del_table(5, "t");

    /* variant batch: del "vbug0" (exact name matching the prefix) -> must
     * also be -ENOENT; bug: 0 (whole chain removed) */
    seqs[0] = 101; seqs[1] = 102; seqs[2] = 103;
    mk_table(msgs[0], &lens[0], seqs[0]);
    mk_chain_new(msgs[1], &lens[1], seqs[1]);
    mk_chain_del(msgs[2], &lens[2], seqs[2], "vbug0");
    send_and_collect(msgs, lens, seqs, 3, 100, 104, errs, 1500);
    int bug_del = E(errs[2]);
    printf("variant (del vbug0) ack errno: [%d, %d, %d]\n",
           E(errs[0]), E(errs[1]), bug_del);
    del_table(5, "t");
    teardown_veth();

    if (bug_del == 0)
        printf("REPRODUCED: exact-name delete matches the prefix hook and "
               "removes the chain (control same op %d)\n", ctrl_del);
    else if (bug_del == -2)
        printf("NOT_REPRODUCED: exact-name delete correctly rejected "
               "(-ENOENT)\n");
    else
        printf("UNAVAILABLE: unexpected observation (del=%d)\n", bug_del);

    close(nl_fd);
    return 0;
}
