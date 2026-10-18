Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C7331203;
	Sun, 18 Oct 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342730; cv=none; b=COghh6gtubcFadP5r4QxMoVKWn72pPI+sBeELKn04tHqE4tvh2H/CHQtIasc4dwHvsYKsGX/xlcC6IFKPMthP0Ne9uWqUJr4gpoIr9kqs5VQtl04Z7aVwOHx15prKNmNclFw4o93nCcA0Ze2FDvRV4xVWDVZLn8O6qVRJkos9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342730; c=relaxed/simple;
	bh=a9ZLuVAPUV4balm/HfDs0B2py8S1yDWizsDORBq6Te4=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:MIME-Version:Date; b=KKOKGYjov7ZEGiTPnWWeWQFJHSzMOn6UXcbEGYZ6vP17SP0mylM1rSSTH7ESqWwXkfTCwpB2DqX4EGT7s/SFI57H9aC7u76jOciGngT6ICKSk9kxxtSoIPigUe/4myssQmTGbfz1uQ5P9EfboRy3QADbUJl5b7Ki2P39pfRPGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=p9fc1Tnz; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="p9fc1Tnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792342720; bh=eR5zmCcZwJ7i97VNb2FuIuk3JaC22Tj16ytPZDzramg=;
	h=From:To:Cc:Subject:Date;
	b=p9fc1TnzT1i+7uuyTt9J+CRu12CqW7bpvtN3FyovIdXioNDLGaJljDUhIatt16fNl
	 9mazWWCRx/qmah2BOZzBwuOSO9aLQm/TLFJW57IBdd9ah2ie+4vsVfiF9yxjE3D7/S
	 k1+NOSVY0J0cLtz8qo/c/BZ+OZozxA0Z+7zWwkgg=
Received: from [127.0.0.1] ([2409:8d5c:c30:3b3:3d39:a6e9:e5bc:61cf])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id EA50E623; Mon, 19 Oct 2026 00:58:37 +0800
X-QQ-mid: xmsmtpt1792342717t8e8ijgwb
Message-ID: <tencent_2D4F4848C75F5AE9E26589170CF60CC4DD08@qq.com>
X-QQ-XMAILINFO: OfxHHOU34G6ph8HVix5ES5M12D7v6wyFVdJSxKW8E32xvQTOGhvH+SyvBIabSd
	 mOumrbPb6ZlY4U+TZYYHPsrallNUe1q34tFaGcX8pHU4ZUwhSqjT+P61l4a6GaiKEvUMQ1l0kh/4
	 /YjogLFEYiIHShOYovDeuu8mF/t2p8WQspnROP/8OW0hk8qVJtS9UawsIVxrD67ECvHBKaZABnSD
	 zl6Mfg7McGNOw0NUnssqtUoDs+NFimq5urXa6pTcg3i0Ayg/UEMPlp5RoJDsJqAcPSZ1yv4ZkUOi
	 losxhvhkFBwW3ysCmKKBEP19crirFNuSfyBNZzwVG8Jwq/O4XSi+iCCW6c6RbEdKC18JVV+w53JT
	 r7vmoasqwwb8wHjrI5zXG43W/TzScO6l56ktuP+DilTViNQwZ65XL8lCwEAXmlRWsOLdycl9A6dB
	 ed/zRCYB0qqi3wWYQsCdH6e3B9RxYXzt3K01y0Iz9P3JkQvNmkkM6Uws6bpQMcRXdACSfxQr/dhp
	 sTnl05yDiYumAVsweelJgQX80nJ+9BgwKIUmgArhnQChnD8ER6MoYQDiWGKlDm7+oDvYGG2Y7ygC
	 TIibfoKtsl6HM10tyxu9gmAo2I3daUxQzrlqXvGnEg1NiclFaOLUY6Vy4NDvdfSZeKQQQ7njDenE
	 CzbTD1OKns3J3TWkH2PZ46wGnnH8qMQKSHwC4vCkCnb5Pgay0MKFD1LGLjpKEO2xxqvoDRCu19xO
	 deB+8vKAyq6JT0Gq6Xyq9pj4avMkAMzzWOj1FopJnTPyZW/+o3EnToh8A+T7AmSXalb+uz++5owF
	 cdVjBjEGt1cvlm9sCHBjJqkEYhDS63OVzRbpQY3y6PmzJJkSeE30TWGGfDpbDTYnsirTwTIliGNJ
	 LfvKAMlLXrovgewWUoBSNHR1HlmEeH825z2Pp7xhpZCZt/1UB2wDcYxwHmk4WYWepdJD0zwNIVam
	 kH+PoUf03G6t8z16bBZL10mRYO/B6rjqPh6BKS28RMo5x5Kh4lmo2UGE19kAD3GhHcg8kZXKEswr
	 ws478PYjR+hJ9BYaNae00IAFic5uSspDyJCHjKPg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject:
 [PATCH net] net/sched: act_api: collapse duplicated slots in DELACTION
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: bulk
Date: Sun, 18 Oct 2026 16:58:36 +0000
X-OQ-MSGID: <5e2b0a920e944b93aa6fd3142fb7fea8@qq.com>
X-Mailer: git send-email style plain-text report

A batched RTM_DELACTION takes one reference per slot in
tca_action_gd() and drops them one by one in tcf_action_delete().
Every slot also calls tcf_idr_delete_index() with the index it saved
before the put, and that helper drops the IDR reference as soon as
the count reaches zero.

Nothing stops userspace from naming the same action in several
slots.  With N slots holding the same action the request takes N
references, performs N puts, and calls tcf_idr_delete_index() for
every slot whose put did not reach zero; that helper drops the IDR
reference again each time.  From N == 3 on, one drop lands on an
action that has already been freed:

    refs = 1 (IDR) + N

    slot 0: put -> N,     delete_index -> N - 1
    ...
    slot k: put -> 1,     delete_index -> 0  (idr_remove + free)
    slot k+1: put on the freed action        (refcount underflow)

With two slots the second put is the one that reaches zero, so
__tcf_action_put() returns 1 and that slot skips the
tcf_idr_delete_index() call; the accounting stays balanced, which is
why the bug needs three slots.

A three-slot RTM_DELACTION for an unbound gact action (index 0x1002)
on 7.3.0-rc7-00245-g32c52ec87d62 reports

    refcount_t: underflow; use-after-free.
    WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
    Call Trace:
     __tcf_action_put+0x7e/0x80
     tca_action_gd+0x439/0x640
     tc_ctl_action+0x10a/0x170
     rtnetlink_rcv_msg+0x14c/0x3f0

and returns -ENOENT, because the IDR entry is already gone.

Collapse a repeated action while the slots are being resolved: the
batch keeps the first reference and releases the extra ones, so the
IDR reference is dropped exactly once and the delete succeeds.
Comparing the resolved pointers is equivalent to comparing
{kind, index} and also covers actions that live in a per-action
IDR.

Fixes: 97a3f84f2c84 ("net_sched: remove unnecessary ops->delete()")
Signed-off-by: Hang Nan <2122295973@qq.com>

---
This report was produced with the help of AI tooling, so per
Documentation/process/security-bugs.rst it is being reported publicly; the
reproducer is not attached and is available on request.

The two kernels were built from 32c52ec87d62 with the same config
(CONFIG_NET_ACT_GACT=y) and run the same initramfs.  A batch of two distinct
actions is deleted on both.  Two duplicate slots also delete cleanly on both.
With three duplicate slots the unpatched kernel prints the warning above and
returns -ENOENT, while the patched kernel collapses the batch and deletes the
action (no warning, rc = 0).  Each kernel was run twice with the same result.

 net/sched/act_api.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9eb1dec..dc51ccf 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -2021,11 +2021,28 @@ static int tcf_del_notify(struct net *net, struct nlmsghdr *n,
 			    n->nlmsg_flags & NLM_F_ECHO);
 }
 
+/* A batched request may name the same action in more than one slot.  Each
+ * slot takes its own reference, but tcf_action_delete() drops the IDR
+ * reference once per slot, so a duplicated action must be collapsed before
+ * the deletion starts.
+ */
+static bool tcf_action_batch_dup(struct tc_action *actions[], int n,
+				 const struct tc_action *act)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		if (actions[i] == act)
+			return true;
+
+	return false;
+}
+
 static int
 tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 	      u32 portid, int event, struct netlink_ext_ack *extack)
 {
-	int i, ret;
+	int i, ret, nact = 0;
 	struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
 	struct tc_action *act;
 	size_t attr_size = 0;
@@ -2050,8 +2067,16 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 			ret = PTR_ERR(act);
 			goto err;
 		}
+		if (event == RTM_DELACTION &&
+		    tcf_action_batch_dup(actions, nact, act)) {
+			/* The IDR reference is dropped once, by the first
+			 * slot that names this action.
+			 */
+			tcf_action_put(act);
+			continue;
+		}
 		attr_size += tcf_action_fill_size(act);
-		actions[i - 1] = act;
+		actions[nact++] = act;
 	}
 
 	attr_size = tcf_action_full_attrs_size(attr_size);

